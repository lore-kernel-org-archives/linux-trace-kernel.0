Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478925;
	b=S6CRXAwoI1/h8nI92zrApcviaU/KcG5pAmpklrnM68n2OIlw3mCycN2gOXmKD4T1uasp
	 /xA0SLdet/9PVJ7m+1JgVmMuDfcbOIn83E3mOxDaJWqZlWG9A69oUgYgHnq+Mt7GddawN
	 XPTKyZQ+iPdfoodmgsNwFPNCRmerDDdW0qvHNx7nGtXp1yaKu16rzzdKrVz0r9rYrpnhz
	 /W8P3H6eJgI+4kjr1EkxOu58VyQlMgDb1Ed82vzDB/zeN1H9NaXMmSadEBRpxqaOBMgoi
	 sx6JLcszg9BQRP7Yt5Aql2JmZ9agTxgoxrqNSlFyj52GlY7xs8/tesUUFNGhbXRkcKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uowx1pkDTb4NperQz2xtneX54qAZAB1zTdOS5Ap0tkI=;
	b=2wyUfKyCSFoDea8yw52+HFRg5VB5PVHSpc6ZkUswaOfAML/DyDOVNA5ltsXH116t6BEF
	 XtBmR6+DEIZNiUrm9DXsRwpvsnfGEN6jslJLqk98oB+aBLr8E4/+BfQw+dzfO8j2xyHpQ
	 r0NkUTsXykdb4tqiqgia+ycRuEBReQCLYP+Cesv3ZoTe3RWN0IVAYMLAAjftUugH2X+Lt
	 NzG5do4vDxff9pU+ghbxSa1XMBuoiW9kwZbUh7Qk0zqSz7iBQrBlehyLsNIM9xRu605VY
	 axMPSmhSqhi+2W2N9E19UyeQJnFrk+cTOZcXYo+EJ7s/SQayGRjM7ke6ZBa0FxT6DJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y/SJe+ZR";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90D606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A90D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y/SJe+ZR
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1438d9363fbso437427c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 02:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478924; x=1795083724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uowx1pkDTb4NperQz2xtneX54qAZAB1zTdOS5Ap0tkI=;
        b=y/SJe+ZR9+2V7gOmXRL2T6cFYN7nJbVcJP+LyR9YosSapoxsfFfM/KqjPm80zG/5Ri
         URw+DCJgemKoF9llBk4H0l4CkbA0LVSGLsYprU+2NAyC/CCkUEORehly4VbhibENBSNv
         KAXanrYSaTlAXfVTwDZYsCbYoZE9D0YW5BIRurbg5Ld5hD/9lffY2BUXV9MryrhtjnpF
         071b89pwqfp4tmr5M+5kwGlh6tsdLPEY/2cdhyVP/noDL3mMk+NoDXIaTgp7XoIiYYxz
         deUTiwNVvSCAMFVydtYpEIGOqe17ou1jWEPD927oda4slvGeJQdFtbCvw4UuYFJ7sayM
         CiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478924; x=1795083724;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uowx1pkDTb4NperQz2xtneX54qAZAB1zTdOS5Ap0tkI=;
        b=FPg20mKQr5Qrk2QK2mxQG0MxUjV9TejBKk/EWYKsQnheHfd96UpXbF2UArgHwMWVuG
         XgaXu4oKVV8PzcIX+U9xby5KWQo2nqYbtNlzUC8S49sGIEc09ohw7J3b3TAFzzT2fC3e
         metG9TY3lmE7cChqDe0OFlibhBhjsIclnQ3symIvD1A3qgV1NdVZddCpPHDN7Bldkk+P
         oc+jPX9vWFF7wm5o3q9YPAfZuC82YAAQ+LrvH9nMV0ehQVm1UMVCjSiOEfb94tOX0WzU
         1t8Z4sfy5fI7jm91WJaBWzFbQpdT8Siz328QeGZSg2wudr1lGxq2qcS13yWl1IhfQ/K8
         Zy6w==
X-Gm-Message-State: APuU4Z/1NizgvhKleYtMxpirxZCdl9gbKLKY7WC9hIXL3yNTu2prTIKI
	fpf/6qF268jGfnUtiiPllqTzgIuMcKeTYGruW+OJ+0nyAITcFXvQquDkCr+2WA5td0c=
X-Gm-Gg: AYBFou3KKhgiSXfVw/sdmYmyHLG3xj6BOM1xmbvvvjntssMY3wNXrjaEPVVmjs7dp36
	MwIHyWLIBRc8J9wZLTaqaSByRcdcStHC25cLBhLzuTDJ6MWvxovk2UW7eIpIe+pp7AyNAJfiIYw
	qhjJj/VJhJzduY8xDMs4wzYR6VpmxJ4xaKxTl8b6871pET7XhIdxODXMG5X7qO5bBg9I+SPqVp/
	oGqgGAFhGBpa+Mc4kNeesDlpiOvswGjLhB82Nc1BfHevc52X/zvwlBe6RktvxCfGm1Jig896iNE
	mKf4HG1ly1+PGJyYnNYbxykS+VQo2NX9neMB+uebQZPwXjvS2srnjoN8XJXxAns1D4VFj6Yr4jq
	1LMDsnIKgGW60qSJdxTHJFKN5EXwYJnJm0suHfZUT2bJqsyHT9edXEENaNzHK1030cwE1tEOSid
	bdv2ySipjA/RcJdrq0s9NX8VGTg+wG3NTcChCYf2pV5r9Wue6DBR4Jam5qwAS72yIzdqq01j9zE
	Qo17mXNZoKBtxyZQ2tfBBdtocZz2I3SYhK5/0ALjLqWWAxbcAgcft8TpglerkTZo4zn4k5v4cNZ
	PGRatwHquBsPd+X+ZXrJsHAMKYvvYyerkzByH3ZHzg==
X-Received: by 2002:a05:7022:ed0b:b0:17a:a3d4:8b17 with SMTP id a92af1059eb24-1b4f5e9dde3mr1645864c88.12.1794478924186;
        Thu, 12 Nov 2026 02:22:04 -0800 (PST)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm23649633c88.12.2026.11.12.02.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:22:03 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rvgen: validate the monitor type
Date: Thu, 12 Nov 2026 18:20:20 +0800
Message-ID: <179447882046.254241.15114935256138596418@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From ef3ed8fae481c0ed3dd16c881aae455be9e92f2e Mon Sep 17 00:00:00 2001
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Date: Thu, 12 Nov 2026 14:26:10 +0800
Subject: [PATCH 1/2] rvgen: validate the monitor type

The monitor type is pasted into the generated monitor as RV_MON_<TYPE>.
Nothing checks it, so a typo yields a monitor that cannot build and the
tool still exits 0:

    $ rvgen monitor -c da -s test_da.dot -t bogus_type -n bm
    $ grep RV_MON_TYPE bm/bm.c
    #define RV_MON_TYPE RV_MON_BOGUS_TYPE

include/linux/rv.h defines only RV_MON_GLOBAL, RV_MON_PER_CPU,
RV_MON_PER_TASK and RV_MON_PER_OBJ, so that macro never resolves.

The accepted set is already in Monitor.monitor_types, which the help text
prints.  Pass it to argparse as choices.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Assisted-by: LLM
---
 tools/verification/rvgen/__main__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 246b43fa2..6053db5e5 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -38,6 +38,7 @@ if __name__ == '__main__':
     monitor_parser.add_argument('-s', "--spec", dest="spec", required=True,
                                 help="Monitor specification file")
     monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True,
+                                choices=list(Monitor.monitor_types.keys()),
                                 help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
 
     container_parser = subparsers.add_parser("container", parents=[parent_parser])
-- 
2.43.0


