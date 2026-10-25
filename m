Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949749;
	b=1VrXikrD/+UWAPCtUTztaVZB1ojt33J50o//Tz+6ZjvzO+uZDX94nt5zHo6uW43Klwl+
	 dOohGhbOaHAhbtn9KjNVLUl170+5EzFsAUBTP05aCnG37y91quuXnc93f3o43lsRaFCmK
	 nlnkt8NciaeJI8ogH4ZMPULmWnrCTn7UYN3W5OBKeTkhu7FZzflbitcF06PgxajJXcemJ
	 yvDxX1m2XNpeZhDSsZGSSogThBuH6fmugmDjNmT/fwpa/ljnTh/XevwP+9wg58gehqLhS
	 ue+YegOo35fgCok1PKzGd3YwY4PDKXY6AeEyWlKST8TQUcR0FlLk3RZ1TYAe4oPvLxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tmiklj6vnw6zb7NyBqdQOEonm6Y3lQH7Jog2rapTKMU=;
	b=MPxkt/7ls8cYMrAhKTPMQG0mV9YFXtd/+a5gy4J185N9f7FLVrTQHZVT14EJgAtpAhc5
	 eofYpHbdtmTHzJ2WKq0n6vaEZ55ZczzSYcZQW4AcLKBvGtqU6p6nKAkq53TMmwT01EVId
	 JXMUNOmmGMG7AX1J3iLFYZAwSwjSfn9FwNu2s+ekXUYEz7EN1TZgwLs5o0kL/Qx6BGT36
	 7Oh9DBCwniugohfok8TR6FxoHJWeOQ+owQBL+1wtg2LMAErHdoKcPLWH8gKrr1mNhSsLV
	 ovJQTvkz3yYaLQcGxytP6PMZe2cywRCCdIF4ckDosL5nSg/qU6Jkv20oBJ5Si4p/zKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OyWkbT7P;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC3606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 17:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FAC3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OyWkbT7P
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso14557865e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792949747; x=1793554547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tmiklj6vnw6zb7NyBqdQOEonm6Y3lQH7Jog2rapTKMU=;
        b=OyWkbT7PmFHun3lf9RCxXN7/zsJ+yJK79+pQyEtQyq9pU1UFfcCT0i+1hYrQTA353E
         UG1SRGf4Iubk0VbmBF/lEXpuY3aPZHn6w1MgigM2JOA4F8CEIOjt3lnNdV4WJciGuyuC
         Yk+u9pJXJMSwFGQlx45dtU3Wj53XW6TkxcSfM7WLhLNTxJD9+YXbp33Z24E7vPy3AePF
         IWwdKnZauI48J8NRgMgXsDf+vTN0GvABv/sY4vidpmoTVflyro0u2ApALbQYLvtvBLzg
         cvZppyqmsnJpJrBbh6DmUTeHexMtVBi7nQQ4SwPkg1iQAJ6oGcH897RK1oho7g+6bwhX
         L47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949747; x=1793554547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tmiklj6vnw6zb7NyBqdQOEonm6Y3lQH7Jog2rapTKMU=;
        b=kBs4Zc+laGEye8wFN+PwOA4UcVCWPUzmCs7KrvoWd1ca3mN31KFhM9tTOoFmbSewaJ
         nwnrDpZhl5qh0ZPyN4Has6P6hnViOmeSlXUay6WY03oSALwF2qCxSfAoUxoy5Bp2PED7
         LJ2tuty5sK9iGl7mcvN3lcEvc+zpppa4Ub7ROzglIUzaPcteQK1daZ9RaUXTqFlcBV8/
         wWDjaRr+vC+MGp9j3WFiSAkOZxCI59T5fzhW9yA2HKS/4qKpuLJHswsA+KXZBoAMNnux
         0cEGvMr2AKdvoYnWYkMLqR/RKqJDvozM3eKKwzAo/a9ayaZowDfkPfkRyCkBR3KZJEvv
         nhhA==
X-Forwarded-Encrypted: i=1; AKwUvBxo5ZJLQ2P5ZPKdCTl61uJyrxr/zX4KTa8IiQBAtvs9hO0IOmQjrXWZpVb52rpo8g7mQT3DpjCNhRG9XRXFRqdgS5U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfqNC+GQmsVQGUBJKcRhwujcCOCnI73R64IMXeQtWXi+WPXM4x
	s3l8CGo1ByVDkfmTpcDxey/9whqBnZpvbXP0czyDhNJAc9KZEUSMV47wvDZDTG/q+5Y=
X-Gm-Gg: AYBFou2ToELmI8ETIQG5FzTTl4C6cfa9LYI8WZQPHvrHeh2PVVnFdqqJ/sgBJBciP5f
	pgTaoAmuYFDWbEd+WhHKHg1SeOZpC/NKR4BPLjWW1U0Xbn7pjlxIl9QNjTYb7Q/hrJB/au+ibie
	+IrbTApaHM+LOeiXz5BiuMBZ9bnAF8SIHdbAROovVkdkYwta1cgVkzJLSN615BqlUT1lrJLCWuU
	pzJmMti1ZAcykeoZcz8/jU3HQKbX6wvQcJELS6NK7u1mOTaXntCVU3F7CnwVxFTXvnEOPYSlVTQ
	fOQuGKj1VQsrSs4vwRyPCTwGfgq6Q8qNxVXQY3IFJgTHam8Hnb7Tn7KwGxzMqtMMOjvSikaO2Wp
	bagQrah5l0MAIMbId/kFyCMnfOAjmH2cX/1eLaOUx++eDS1nWCBD9tzQojoYCKc9NOKXLwV11N8
	H6jRdUBqGPcxrjEtM3xvTJ2YBNPw/yHIi5wUKPcErfbR4HZBSA3NZrrYIntlTilS9VkgvUkqXbq
	nbz63JHeIxf5CnE5ue1RMieMzpeFox7ZDuDgwlGQhTW8fbyaFQsqFI/oyg5+g59F6ekyAYKjSOG
	+WP4xM5sPmKTDWaOAoG5cbprCx5pqgkr4KlnAo/SYPopNyh2OcZN45mswAxPW4vODE9yJqF6rkr
	7meEVhHt6xxslJng4XRwortqKd/n4taHy5iSq8HKH4DvhmN8Z/vKb9L2otg8yAeT70Zb8C32eAj
	6dgvvNvktQ
X-Received: by 2002:a05:600c:8b78:b0:4a5:dc5d:20f7 with SMTP id 5b1f17b1804b1-4a5dc5d2382mr23377865e9.14.1792949747369;
        Sun, 25 Oct 2026 10:35:47 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-ce3d-9b69-45b1-5da5.rev.sfr.net. [2a02:8434:fda5:4201:ce3d:9b69:45b1:5da5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb90dsm10234070f8f.22.2026.10.25.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:35:47 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] tools/bootconfig: Preserve event trigger filters in ftrace2bconf.sh
Date: Sun, 25 Oct 2026 18:35:23 +0100
Message-ID: <db9a1e4c2e86e19a4446ec81c1684ffdac02c265.1792949723.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792949723.git.edumucelli@gmail.com>
References: <undine-1792936915899334889-d965251e73c20670@undined.local> <cover.1792949723.git.edumucelli@gmail.com>
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

ftrace2bconf.sh reads each trigger line into "action active", keeping
only its first whitespace-separated word. For example, a histogram with
"if common_pid > 0" is exported without its filter. Reapplying that
configuration installs an unconditional histogram instead.

Read the whole trigger line and remove only the trailing histogram state
marker. Quote the resulting action so that whitespace in a filter is
preserved in the exported configuration.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested this in a temporary tracefs instance on my Ubuntu machine,
running kernel 7.0.0-38-generic, with recording disabled. I installed
histograms with "if common_pid > 0" and 'if comm == "a b"', exported
them, then restored that instance's actions with bconf2ftrace.sh --apply.
The original exporter lost both filters. With this patch, both were
restored correctly. An unfiltered histogram worked in both cases.

 tools/bootconfig/scripts/ftrace2bconf.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index f8f288f90c74..032ac5b10a4a 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -115,8 +115,10 @@ per_event_options() { # event-dir
 		done
 		DEFINED_VARS="$DEFINED_VARS "`defined_vars $evdir`
 	fi
-	grep -v "^#" $evdir/trigger | while read action active; do
-		emit_kv $PREFIX.event.$group.$event.actions += \'$action\'
+	grep -v "^#" $evdir/trigger |
+		sed -e 's/ \[active\]$//' -e 's/ \[paused\]$//' |
+		while IFS= read -r action; do
+		emit_kv $PREFIX.event.$group.$event.actions += "'$action'"
 	done
 
 	if [ $GROUP_ENABLED -eq 0 ] && event_is_enabled $evdir/enable; then
-- 
2.53.0

