Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471755;
	b=cProLuhwgqHLjEYNFe6QVIB/SPlD6+McvHR8DOQ6FdsKAhWBde7Fka9sbRJt4qrTH/oN
	 58w+N1Pe3DIwQtDvbWwCC4FqTTaI2RmBMHyacxVZjIzDC06f7PF+flmS9AoGXUIUNZNxY
	 p7BE/ntz3Cw29qqkmENPJQCz3BwLF7ccG75aXPdd5ItKFhCwIXtLsDxH9t3ANkGpcQFX2
	 nQovtSR3NcHAL6CBxUqxVhaNwEhmNaPpqua4bmBrVPb9UT6I/e/rBYpmHlc4QEJ2q2gAg
	 /wkVMHb+uszY5mbEZtxrwXCRAsjcaOFdLCM4uJ2E0sFfaiwcbO1gAEs+wbsgX0gvr7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yN+TG3cll45GlRcOY9f9N+pL2X7AI2IfUU7T9/nu2cA=;
	b=FNmr0/QvlBDFGCMB6r3ILVTc0Uxm4K+IfHXYhGM33OhXV/NWd1AqTremk2QM/Dj1nRC7
	 1Jye3I3RLuij28otdcl0Mkn4qmZmahEc1/hS+AP+nglKVaBrCxtFnZpeVJsKgAXZo6vCw
	 W7h1HATC6HaqeMCrDazhpFSF7NZfU6ImPeA0VKwlr9v8yfWJmcvzi9gzfnmmVDegUy1xR
	 dpZXDzT0yY1mz6ox1Y8E4qz61XofhkO93ppRQwFdyArqcQk+HFOpBMlXHl80ugbftHdhg
	 BHCkt4a1eWqc1wuZTp0CsOAxagdF73El4zpMyVfmV75MrfQpHXxMvvpflMk8TVeXUeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tFXZPhc2;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5649606A31D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 18:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5649606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tFXZPhc2
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so19648285e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793471753; x=1794076553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yN+TG3cll45GlRcOY9f9N+pL2X7AI2IfUU7T9/nu2cA=;
        b=tFXZPhc25wDITKGyVPKqC3DzYiaZ+oFIdXG++nD2y/LuWK/g275eSvM+aQ79akTaZD
         enjN3K5neTOIYTnJADUWlGNL0W6owwNMW7cXUSwFqNEcAdjaKv60zD0wkLZD4PFxBMFr
         AI+JIaIFkC7G2DPF5FywgNUclcAMPV0uDLRenxuni4WdWUdTnG1Xq6u+d1BdhAN1oX92
         TOtHZelzqBOTZ7aqhfIUkIAJX4sX4Ug1oPq+gL62IPCy1ZpmWVr1JylYueDR3d1sqT/v
         ccn/ntkzbwpxROl6AQtCrruY3t6I5snTGU7WW3qn03HBH/8f5+9Mmm0QforKTdwU4R0N
         voWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793471753; x=1794076553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yN+TG3cll45GlRcOY9f9N+pL2X7AI2IfUU7T9/nu2cA=;
        b=CYwHTDdIhUQLz0Gy6sk8ifa5gREz6OH0Uc5OJuy5/c7OmgHWPRn+qE83PK4cVbmpQD
         eUgoqW4RIJO9I13yHZaJU0lUsktV+U9wWg+g/7FMIRKtfnFqMS9fNrmoOvdEN6GPpudU
         MoGvq6eevu9tOLTnVsSDD6yu/+A5G89y+1+CXQ0q9/H/39SbTuO7JMtuD6Qf1ORqrckE
         F+vnD4Z9BsFkh0VRHO8tFgbyJX8t95Yz5ttGxio3f83c3acpHTM7zpj1K+rOX8YVN/Cp
         TjJc22/DVlWHuda2kKZg2pYVyP+EKXP15XPlmxWWIHNPuJaE7j/voBP0NXy73By2745z
         ocew==
X-Forwarded-Encrypted: i=1; AKwUvByDgOr6djnvc/YpAlo6rAQJFH/4DF3F65f+jjwaZ7eOT1gbW0ewQ9jsoZJBTGCoCIi32xm1W5vFKgvcL4NxSPkhLFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZ3IIZv/f4eaJ8U2yABrPRm7YNT6K60vKelO7v5dOZ5TvCiLtu
	OeKDYTUcTfbr6xPc9Kt7OhaWnIRrVonC3tJj6hJkNQ3bRhIz+SgHCb0P
X-Gm-Gg: AYBFou3cM9m2+YLExn2abtlDHceQOuISMFZz9KBaJUcIPtvzhEQJxuw2BDtSkOMODM7
	hDVCo356nk0xaP1C4HJwr+OYXuLdghv2iEdPI4bT8ZCSLW7wjnIBodekQTsqFmpqk0NIyLlyW2J
	i60hOH3TVcfa0ITlvqxhDZcLHe8yK1ebC1X0KwGdyt1eEJpPQLs8Fpx7Qf7hKNwpRdAO9NQHmN6
	aIFEIkHglHVmvoq4mKgDdJ4svElGII0+v8dWYgxJGflkUJ7ME74RBhOt78DAnwenErQrUIryEs7
	pa5D0QqGM4g06alvPjBvgfwCQZQpZ49fmIsLFDQdLesFhxHJNebdP+MP/ePXsl+tQUt1FAqWs7/
	x9h2406PtM4DOzTW/ffCvy0uCNCI9QIoCyN5I2wKYNKrBVXyzzR+17sVwYUZk+aHQ8WtgOAtKTZ
	6WJJMcifZIDTu8R4eN6izW0SabFFl9KrblpAW7xabKj0wIcIjMijuihBPFGxxpuVaKDuSjsEUtQ
	8FePYygEv3EGdXsZ6MLh7d1IVKTNWCmcViv86hcnBFXfPI4DYx78DhIKuEXD1hwMqLE4/45SDDB
	KoZ0A7jNfZGM+ER1X0o7AQ6popekfTpCdjrSNdfKHWPPXZKoChSg4a8582gKRMYYy0DWfv+bMze
	fNuSs4970XYYiUG047amU19VXIb1eU3kFnsJhfplmxpnDIoq9rXnCdXGTB2ZlM/b7+Ngt9kAkUn
	Zq0zDHVt96RloowM0NcGugHTflriAA6QpRaN5JaCAb2yWA+ocNAOYG/dTYVSetl7rsp1PMngaWj
	cADhyfxcEtLRH0yVjzWyJ253Lgl2n//XtoqkA==
X-Received: by 2002:a05:600c:34d6:b0:4a2:1364:252a with SMTP id 5b1f17b1804b1-4ac150b2192mr132858705e9.3.1793471753435;
        Sat, 31 Oct 2026 11:35:53 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-0247-bf06-1f38-d09d.rev.sfr.net. [2a02:8434:fda5:4201:247:bf06:1f38:d09d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm219745075e9.1.2026.10.31.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:35:53 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] tools/bootconfig: Resolve histogram dependencies until no progress is made
Date: Sat, 31 Oct 2026 19:35:33 +0100
Message-ID: <cc5b165d95ad5f2083453644f70f8b194874598b.1793471731.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793471731.git.edumucelli@gmail.com>
References: <cover.1793471731.git.edumucelli@gmail.com>
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

The exporter retries unresolved events only three times. A valid chain
of eight histogram dependencies in reverse traversal order therefore
exports only four histograms and reports the others as undefined, even
though all their providers are present.

Retry while the unresolved event list changes. Stop when all events have
been exported or a pass makes no progress, preserving the diagnostic for
missing variables and dependency cycles.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I installed a valid chain of eight dependent histograms in a temporary
tracefs instance on my Ubuntu machine, running kernel 7.0.0-38-generic,
with recording disabled.

The original exporter emitted only four histograms, so replay restored
half the configuration. With the fix, all eight were exported in provider
order and restored correctly. Fixture checks cover shorter and longer
chains, missing variables and cycles that must stop without looping.

 tools/bootconfig/scripts/ftrace2bconf.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 8ba1a698611e..b3c976bc98c8 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -203,10 +203,10 @@ event_options() {
 			per_event_options $INSTANCE/events/$group/$event
 		done
 	done
-	retry=0
-	while [ $retry -lt 3 ]; do
+	while [ "$UNRESOLVED_EVENTS" ]; do
+		prev_unresolved=$UNRESOLVED_EVENTS
 		retry_unresolved
-		retry=$((retry + 1))
+		[ "$prev_unresolved" = "$UNRESOLVED_EVENTS" ] && break
 	done
 	if [ "$UNRESOLVED_EVENTS" ]; then
 		cat 1>&2 << EOF
-- 
2.53.0

