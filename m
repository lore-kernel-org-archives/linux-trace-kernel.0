Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356638;
	b=IqRSOVZ/U+WwyumRMi4wsA5KCPjS5I3rJ748+fgWr2C5BRmF4QpgtGp776EucmpfXyie
	 raMVGXXTyh5YCnqth4O5GSxr4hrajYUCImIkKduiIBCCvN8x3zSY57chncXXoEVfW7ZSe
	 mqvXI9YVe2mEao5OfXfVR0sTCde+uJJGTqU2B3IQiKzJzOM8V69ZYnCnwDviOOoLcJ3A6
	 yTC0MG6xPoaSZDbp2BbelhcXtgNU2f5SXMJ/0WJo2GvixUzzSSAvgucRC/zZlbMoNb2P1
	 Q8jmIXI0xC6baRIRTaZl5tb0fOGHGKBW/x1ki1SJhChOzKegRzgNTux19j3YEiX4IWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G2t3hxnV5uVy/7NIAyuXsI6XhgVjpyjdFNofy9ee7Uc=;
	b=jP002zPpgV0jAMDqwJzkFLDJv7mh0Z84yts9UqQxTb6vnVvuGHdTfwP8Vpwa6wd5+/wv
	 TeYm5329KXwoYG8PWKh0Ka4kv3ZM5DBkUVWBbdKlh4MB0F7Ay2tmaHVbaqHjhS5yWv9Sh
	 QjCQ7pVF8lYVtP0qYoVUXhpSfiETeB9wDiKOYUJn74sUl4jzmDyT224zlef5j+PN4+Quo
	 vkfV4TyW0uxcQrHBqO0gsQeUTvRl0Xs4JDEVtmfIXzsNlQyBrVmWLZ7l8/IUH0dtNLOPJ
	 xCKwX7vt1pRkbncpCsKB0lL7H1T4WnjdgcdFPgOzvgEnRBw1MTdBPdf3QvIRBfM1b4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fkk1t2V9;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46194606A320
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 14:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46194606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fkk1t2V9
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-491846221ffso1986315f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795356635; x=1795961435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2t3hxnV5uVy/7NIAyuXsI6XhgVjpyjdFNofy9ee7Uc=;
        b=fkk1t2V9Erpsz7v+sqd/JEeADrGC0TCv7P9P5QuI4HlobXL3O/Y789uxXBOSnAw+Xn
         464D2fnMU782wbYC6AOR6cpMk5+9qsaPCMTBEZjofxgPJ42BJCbYY4oZBNW5AKZzvhKm
         YqXs3MVYIpjutpTdCBhuGq+r9q9/H//RVDLjN5gzX1C6vRP0ErhaI/5JSRD70EMP844f
         4cxMGZH0bueGw7vQnmH7CwHg9jQpvdiUL10NpH8YdbrMykgM7RSVqIBewGqGTRqsIunB
         molkHf0PsOYJvLqLWnC3MAtoHXBYEdBdWxIUsIx7h+CBeKa1cJLYWfxSZvUBEc+UtV0k
         PNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795356635; x=1795961435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2t3hxnV5uVy/7NIAyuXsI6XhgVjpyjdFNofy9ee7Uc=;
        b=p6nzuDsds1EI47OMzXTK+1XKnY7MRXulNJvbLyChHpEq1NWyeEUPm7u+ltOc2Ufq1M
         MXVT/76JoGfB+Bq/TxitrQySebbKDrRYstw5DCpxaFuq9sG9YWCr/QT3UCN+lXRUfNNX
         yA7lTH0kuU48ZM4Ztg9tvO2NdN+lTF4MZBfTATwkyMHBrOoG+dcR/eWJxZ2w/nrZRPUp
         EwarxpnKsu6s4P568AA0rnAaeSJRVMUBrhbKjt6kKLGfIs52Z7w9pJuD6ddS5VLShr+y
         ug+LoczDrwZED0QbasA9tWPBm6mX1XGwRLasHLaeYm7lpDOSugMWvX2ozqgvf7ekBJLx
         gy/A==
X-Forwarded-Encrypted: i=1; AL+hErFHrZ2pGTE4Tm23to+5ZVpV5QZA9bCP1eCBuDgoNUM9S2RSYsR36Vvqp+zDvar50RvvUILUhpaTMLEBRDGnoObAGWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZCKvwDgeKyOIbBubom4/c4l6nAAh8d4+vAxPd4ChNu8fSbIDC
	THJQNe52QNazbeV/5wMhJ8cS2DTqYK5GVlUYSOiyHgljhznLLDTBoz0v
X-Gm-Gg: AZFdTZdrRQ8T8eZejuUZ5+5Wxj7uUq0Z9VxRuTUxD7CLtgoWbrJUJnAIkCqceDdzsZO
	qzxpftHTps2cFb+IIGqucV3Bm19+clhnrySwTthNP9ciJu0ckn1rFUzpXfstr533h3ToDt3fXig
	0BWfIkn9hPF2RMTC1XWRS2MhJRhtC8FcF5T5xDKK55X1lJWXvJgIyUlusa1kWmR+263VEbLCmhf
	l6OS2Nkr8i8qrp/g9YgYLNMqJrHmiLYr92IC5eT1An7JEsApBnhKWydmmiN8CKpBz+Spv/60Wys
	BdMOUKgSifXKgIXNmP5jJGJgOzZt68mJY07UnqjjHsxx5bnGNEhc62RT6GCE+CKy53oPhquuww1
	nNAZVR9P+leRf/9tdLWNZSL8FYmhn41dep4NF2vdA1SD9vyHIRwIA55vEcwmzfxCkc/nckeuPSo
	NUbdKSD7DJeJdEeavcu3SEG6ZZH8YfGDtGnViGFvOVQuv0waJtTemgJL3kar1CrtNi+iMcH/uR4
	0jAsE4WUlS/ooKDDs26lsInSIRXkBJ0oAgs/x5C3JiXcW95S19NOMt0D1yu93wrGRFeWjGgjxFV
	v1aGObSlu7Baa7J9gyrrvR08u2kImE42WEJFb95+J4mkH0hHRpQOWeb/bVLCVI93Bke+frYYgo2
	dmi5dFSmgi7Cq/ikM4a2R7Z37YRTSPZDSqAn23Rn/UOBI/ubbvhoMaoscbsDjTuSptJSQ97jDrm
	DoevL+a44hy08mvENAwk0LiCnrEqu2Az52koabCn8ubaF5tUzl5mR04/Q4DJaDj01BEP7c1WVmG
	VDnNXre6xbjeq+2qA==
X-Received: by 2002:a05:6000:1a8b:b0:48d:ed0a:e064 with SMTP id ffacd0b85a97d-4abb27274dcmr17739295f8f.24.1795356635492;
        Sun, 22 Nov 2026 06:10:35 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-2025-a95f-1d53-595d.rev.sfr.net. [2a02:8434:fda5:4201:2025:a95f:1d53:595d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa397asm17242835f8f.48.2026.11.22.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:10:35 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/bootconfig: Reset the tracing CPU mask with --init
Date: Sun, 22 Nov 2026 15:10:24 +0100
Message-ID: <71818e9f5a5925054b04bee1a58b63c43ff02361.1795356623.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <undine-1795340207193471810-f6280e0e64aa2f7f@undined.local>
References: <undine-1795340207193471810-f6280e0e64aa2f7f@undined.local>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bconf2ftrace.sh --init resets tracing before replay but leaves the old
CPU mask in place. Replaying a configuration without a cpumask can then
keep CPUs excluded by an earlier session.

Read the initial mask from a temporary trace instance and restore it
during initialization. The mask comes from the replay machine. An
explicit cpumask in the configuration is applied after the reset.

Fixes: 5675fd4ef51f ("tools/bootconfig: Add --init option for bconf2ftrace.sh")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Masami,

Thanks for pointing out the portability issue. I moved the reset to
--init. It reads the default mask from a fresh trace instance, so the
replay uses the CPU mask of the machine it runs on.

I checked --init and --apply with a tracefs fixture, including a
multiword mask and an explicit mask in the input config.

Thanks,
Eduardo

Changes in v2
- Reset the CPU mask in initialize_ftrace() and preserve exporter behavior.
- Restore the replay machine's default before applying config values.

 tools/bootconfig/scripts/bconf2ftrace.sh |  2 +-
 tools/bootconfig/scripts/ftrace.sh       | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 6a3535a2c..f105c7433 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -64,7 +64,7 @@ fi
 
 if [ x"$INIT" != x ]; then
 	. `dirname $0`/ftrace.sh
-	(cd $TRACEFS; initialize_ftrace)
+	(cd "$TRACEFS" && initialize_ftrace) || exit 1
 fi
 
 . `dirname $0`/xbc.sh
diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
index c2b993f8e..cf3b5b72e 100644
--- a/tools/bootconfig/scripts/ftrace.sh
+++ b/tools/bootconfig/scripts/ftrace.sh
@@ -86,10 +86,19 @@ clear_synthetic_events() { # reset all current synthetic events
     done
 }
 
+default_tracing_cpumask() (
+    # A new trace instance starts with all CPUs enabled in its mask.
+    instance=$(mktemp -d instances/bootconfig-XXXXXX) || exit 1
+    trap 'rmdir "$instance" || exit 1' EXIT
+    trap 'exit 1' HUP INT TERM
+    cat "$instance/tracing_cpumask"
+)
+
 initialize_ftrace() { # Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
-# no probes, and tracing on.
+# no probes, all CPUs, and tracing on.
+    default_mask=$(default_tracing_cpumask) || return 1
     disable_tracing
     reset_tracer
     reset_trigger
@@ -106,5 +115,9 @@ initialize_ftrace() { # Reset ftrace to initial-state
     [ -f synthetic_events ] && echo > synthetic_events
     [ -f snapshot ] && echo 0 > snapshot
     clear_trace
+    if ! printf '%s\n' "$default_mask" > tracing_cpumask; then
+        enable_tracing
+        return 1
+    fi
     enable_tracing
 }

base-commit: 0ad31c3252d4c626a93ae6251340ef86b18342d0
-- 
2.53.0

