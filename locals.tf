locals {
    PROFILES = {
        for KEY, REGION in var.REGIONS:
            KEY => {
                NAME = "${var.ENV["PROFILE"]}-${REGION.NAME}"
                CODE = "${REGION.CODE}"
            }
    }
    KEY_FILE = {
        for KEY, REGION in var.REGIONS:
            KEY => {
                BACKUP = "${var.KEY["DIR"]}/${var.KEY["NAME"]}_${upper(REGION.NAME)}.${var.KEY["FORMAT"]}"
                SSH = "${var.KEY["SSH-DIR"]}/${var.KEY["NAME"]}_${upper(REGION.NAME)}.${var.KEY["FORMAT"]}"
                HOME = "${var.KEY["HOME-DIR"]}/${var.KEY["NAME"]}_${upper(REGION.NAME)}.${var.KEY["FORMAT"]}"
                INS = "${var.KEY["INS-DIR"]}/${var.KEY["NAME"]}_${upper(REGION.NAME)}.${var.KEY["FORMAT"]}"
            }
    }
}