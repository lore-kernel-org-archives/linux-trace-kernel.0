Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442351;
	b=NK0nAYmU/EMJiWMv9bWX6Ik7VSh0PvDmMBeueNijhw84CD6i6FlUUvIlUG3d/FbMN/lP
	 ecgYSU6QmG8vFrMRDt3AVDWJ0d4wG+Ffve/td6YCdoEgSQfzyGQ+8g5bW3fjenfNvNx8d
	 PtmG2p3bT5MEF8jDm8hrc8Dxsgj79DbPhitMY0TAp320iIPNmIImOVVy6xBrdO1uv8QdL
	 5rPPmN5euat8fzlp/jDxTrIsCiObWovIJUryBzitsxdgKO+NMW2zCZRjV3exDvjh/9V76
	 cmWDlOW7zi1f0tIDVBFP4VSRhBp34ZfBsjSSKlRsEctBGH4WItiMnw1zQaA7U+1eSag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oeYhlfE7rmhK8ThdtZH/4PQ05A5yeiUNR2Ne6QHI8a4=;
	b=TEeAAGkl60uS/zS4/j6AaFQorFRPcu4cKv+zboFGt9xfqI3P8rPX6XGD9saxL2XO2phS
	 CIbGe/0sCsHV94VyV/uWfkd7VFJgbtDEout7vYBIzIhzZUHlH++yeSJejEKHaFpAe5yA2
	 Ra9wNV9AF/Tj5sYNMiO6N0nCctmyHcNWgnTl/x9Bxm0bDhGVCw69gDNUX6zXXZvgg9FUg
	 M0xHHqu0/7bt+2C3X64BEPNpzjgOgNKRfyqkdBSAZn9iOP+Iyqkv0vD2MkMxBllFzCNQG
	 xDCJDLEwQUPwKzEpmZwtY16fKsXBPXsX89tvy/EcpvDAjVxalwDvo0wrEKOT1UX/PsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PVllOt/M";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAD606A325
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 10:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDFAD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVllOt/M
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so8794095e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442349; x=1794047149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oeYhlfE7rmhK8ThdtZH/4PQ05A5yeiUNR2Ne6QHI8a4=;
        b=PVllOt/MLnWJ+5eOi1IQ5f20cGfgFzmlHjOgY5yEjoM7FYpCUMomp50i68GAaZCNGT
         KxKZNntyjvq4AKlmXZHSOh8STsZsypNoABT7cDKLDI63xYgtLxp3GokA1zyIqzPkgUeJ
         rT0HQujYWz+rQFbDwlZdLkh+imZ/CkGgm9W2SfyYlAOxp8PTLleiVlscxsNgoo9YNU5X
         5BctWlcchf40Z+fHGjZooptwd2w1F0K39XT3zWm8V+f35c42tkFV+fyveSLjUwgxqU0O
         aXHsZwlPdHt6kRGrdrTgoIyN61scwAs+Ob0UEM/VGJanFPot7XaMTWEkPPCsM0G/F28O
         8Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442349; x=1794047149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeYhlfE7rmhK8ThdtZH/4PQ05A5yeiUNR2Ne6QHI8a4=;
        b=RJDkLN5infAHCdT0CJLPBgy9/DS9rXI3kso8aOY80QThale8GG3YwaAa/55Z3tzXpc
         Aj1AcMAV5BM+yVn92n51OMH5/e4leFImlMDuqswYUg2Wjk4I/rDghOz8huK4iZIgpW5T
         0EEJJVlGUFgkSM1OpznzvgDQfEcYowZTDm5xMJ89anR7R5ZRcSQ2Iu8XOIYQJ5WOjBJ6
         MzdubA1HQdKwPXWYx4e/WUhY51D3q8Z7SBzHlXXLeyl/aVz7Weg6yYWaEnvTefbhBpgq
         OUP1SAkLKdele0p0hHkEnEnLpVdSGUs14q27CTzl8C2jb5dy8dFMOW8mHqzOl2nUZwlZ
         IsXw==
X-Forwarded-Encrypted: i=1; AKwUvBxtlXrMGsHXRRxmjlnGer887TLtVQzotiWscxiw06Hyw9SuRmit/BlgCSEmfuc5QASHgjulkxVNo5YccjqEDnxDMXo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIry0hN2Nyiv5dLiecKp/LeGDiYA1sALk0JeMHB8L+oVb7mVA0F
	fgrqv1gayLdz8YUdRyhOQuEej7KHBiofi7b0QnhYk5BzxwDXVvIAw3gk
X-Gm-Gg: AYBFou3oUN+jHOl0KdH9/T41YOon6/SXYia0UR0IfNX06aT6ZtDBUVFnM4D7jdPYQBR
	kkQ5PypGavLKYVTbiVLhT1i5pVtf+7MR+X5GCmq3qpFJWXyTvEkKUc5JkuzC8EVdAK1ner4OiEL
	bEFA73whFLOaVuWrXWoCm8gOALwr+ubUZqE3guBJvZx4PPD7xx8/bG9YMiToh/a3AjqXbzNaEAS
	YmU3aT5tNC1Hf9FxFksxpyiw/4W4hwgYzF5JPzICoyYfiCC2ucDM3afW3EQwGrn7njWiOWIsZbR
	SOWhRhL/lTuygEdP3aKne6pcGQuaoaquopKy2H3r5iyzPKpd8jw2y29VLG8Qi2ZcWNu+eYn9dps
	i65WXvrLtIhWsYs5BKeraXXSC6Xaz/e4ka/UUdxbeEXAvA9dvV9/hQ0qjZ5YTT13DkSIecfEIBh
	y3FR+3vC9plRUJDGc3cSnd8Rw15ot3nqSlgcNPDFt4myaLdcMTLytMmiLwUNU+w0llfZFT92qcJ
	aCopEscLbqsFsYN0IFEdcB57vuSL/CrCkCoq+wYd5Ae0mrXQ1amLlBl0C3A3HE0erQcgiRnAOXT
	6DlRK23jz+f/6+NKOlW9HGV0ijvm2XgwneunegS2tv3/w9zyWYVA/3zKaX9/2uLSohJkUlN5ixI
	JFVwfwy8V2LJ7CminlW1bTF+9WDA4X5JoXkBQPlP2kARbIRygJsmorwykEC4Vtv2lsOXSJ8pbJa
	8Jn3hqsmXrmQQcUV7hG1f4Jz2r5u22Ujl3AHkUQcgHQmEe5I65HcCOyBSNFQ==
X-Received: by 2002:a05:600c:4f8b:b0:4a3:5a98:c279 with SMTP id 5b1f17b1804b1-4ac17ffb07cmr106396465e9.8.1793442349085;
        Sat, 31 Oct 2026 03:25:49 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-994c-f615-42f0-2afb.rev.sfr.net. [2a02:8434:fda5:4201:994c:f615:42f0:2afb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm195363135e9.1.2026.10.31.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:25:48 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] tools/bootconfig: Quote event filters in ftrace2bconf.sh
Date: Sat, 31 Oct 2026 11:25:31 +0100
Message-ID: <8cd8a184cf719c75403507c186331d12500b803a.1793442331.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793442331.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com> <cover.1793442331.git.edumucelli@gmail.com>
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

ftrace2bconf.sh emits event filters without enclosing bootconfig quotes.
A filter such as prev_comm == "a,b" is therefore parsed as an array,
while a # truncates the value and a semicolon or closing brace can make
the exported configuration invalid.

Quote filters containing bootconfig delimiters so that the complete
expression remains one value. Choose an enclosing quote that does
not occur in the expression. When both quote types occur alongside a
delimiter, bootconfig cannot represent the filter because it does not
support escape sequences. Warn and skip that filter instead of emitting
invalid bootconfig. Leave filters without delimiters unchanged.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested event filters containing a comma, semicolon, # and closing
brace in a temporary tracefs instance on my Ubuntu machine, running
kernel 7.0.0-38-generic, with recording disabled.

The original export split or truncated these filters, or produced a
config that could not be parsed. With the fix, each expression remained
one value and was restored unchanged. A filter containing an ordinary
space worked in both versions.

I also checked the mixed-quote cases from your review. These now produce
a warning and are skipped, while filters without delimiters still export.

 tools/bootconfig/scripts/ftrace2bconf.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index b01297217cf3..8f3edea79ca0 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -126,6 +126,19 @@ per_event_options() { # event-dir
 	fi
 	val=`cat $evdir/filter`
 	if [ "$val" != "none" ]; then
+		case "$val" in
+		*[,\;\#\}]*)
+			case "$val" in
+			*\"*\'*|*\'*\"*)
+				cat 1>&2 << EOF
+# WARN: $PREFIX.event.$group.$event.filter cannot be quoted for bootconfig. Skip it.
+EOF
+				return;;
+			*\"*) val="'$val'";;
+			*) val="\"$val\"";;
+			esac
+			;;
+		esac
 		emit_kv $PREFIX.event.$group.$event.filter = "$val"
 	fi
 }
-- 
2.53.0

