Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364737;
	b=HIRDM7VaqQUaV4edlCTmuJxfzSVG0b4OjCX0A8OK8JFbhWbzf5aqhO/MeU9+ny+kYNNf
	 4CPw1UNLgA4M89Us3EjOyfQ8Gr8/xFSW8cc6tmOiiNQEKfxSiDpUVM1imgRJD2eMEWtDs
	 ACy8aW72SXotTG7SuPWBKkI166jPrBm00xmZSXLi1hGhMVXm0DJpUOLxsX1PIUvI3Pzfj
	 0O13un2itrIwCgC1LLlS4D88j0KH/p66N0AXGosq5VZfnl8NSoi0blnquM2z9kTOq+IYd
	 utGOR43+ftppyAKk62HDyijVwO8LsnOqeUJ9x9EJ6qzjtcDXGhosbzBEjG7uctpZxGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kzZJMbX6kEn3NZvCxaAxClJhR4ih+ZQw9vsv4EJtO1k=;
	b=fv4PxXqkqox5hsrIqQLuV/7sXulOfSXVF0/OvYl5izjQLvi2RTILN+2ibzIjRvZFElWw
	 swFBdQ9suwh28QTGnB907HKbrY+O33PoScSkUhDRw7Crsv7AIPEPhQ7WCem7On/dH+0sP
	 KSkEMRkWu3qR7sFAk2EsQxGlG+OB2fGUav2T3IHbDHSpsi2ppRVa/e3F76UdtzFUg+i9l
	 GuXD4SU+6ZGy6QAClWqmZVAXDOaHECdSzmgF8MTaX4IIbs45j9+/mbP0AwAips7cseSY6
	 xsrnCdzlqO48uQJmlXZ3NabL3huHkWpWO3H5vqrt3gRGRnbOsAKThk/ZXWERxy4tEAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ej1Rpi9k;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BD60A2607
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 12:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 215BD60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ej1Rpi9k
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so6634005e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793364735; x=1793969535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kzZJMbX6kEn3NZvCxaAxClJhR4ih+ZQw9vsv4EJtO1k=;
        b=ej1Rpi9kBxixFTdjJjohgN8g0qHdMW50Pye0hDl62N/jopsn8Zfn4K1PqOapN3/Gha
         wIcEIWuI7H5z11BhzNr8ljPMaIo9GcegAvsUACJNHLStManBFQe8ZPeNiZQ7JaLDEUYh
         v88sVmf6jBgZ0RGDv+lqBh8kOVhAW1aPiQ2vC65uAB6qoR8byfvN5ybXEaoBq5h4vsZq
         FfmuM97TsQn+2PK5O1dxNsf5dItU2sJ/rYTtuq3+FAV9H5EBarWEMSW8Aq0pGXHqBd15
         sTakJ3sYoKdazqEx74b2HHzLdaA6b1+rnbdc2RljH3bwGaY2a1vMTXenuJEcykdSSLh1
         9s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364735; x=1793969535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kzZJMbX6kEn3NZvCxaAxClJhR4ih+ZQw9vsv4EJtO1k=;
        b=M0wFhPRXayxccTf/+I8F4QAJhIvzRYGtwzpt1Pu5w39Uqb+z7TB8mJD/TMy2BVm06m
         UAplO6a/Dl9+boGbaKbWnZcDs1IxE2E7fQDPx5n2OALVbUAFlVn+VWuWU/mNe4iomVP0
         CYQTSfJxAIE+7s1gSivvhvsnY0TBI/2lKg2uvaAMv4VeSKy80KMdNoIgCfSQeJ3mErGj
         dYqQDn0mwHaBSGU6ifETFXPIuZq6r9b1W4sdQnIQgdOr8r2XeZ2AWgTwQpD8wqTVwoHI
         h4gLAX7Es6mboaKlQvqmnoLAEqjRboZAqn+ysToSUvSuxVvb8D0G9FdY9aLKLZYK55AE
         kBmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoIjCqfsF6Z+WFbIeLwuT5KBnD6EpIbIPfE4K0elZZWaEiLjHgJcRH7pNdrjx64NheQ1/1aHUokHzHLUE6KDkE+IQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK40GHcFsELXsqa8+58pi/2+FOkdrVwUL0kjAWVF6pnrSPAfVpC
	gsD7VwRhKU6ya+YZasBMgVxO1bYgvw7sFnwBZYFuc0jE7eWPoLkr6R6D
X-Gm-Gg: AYBFou1BzAusYGvG1ykL5to4dJKpNcwCiCzgOwV9SHr0JsFxIxNVXEZ1WFTC6FWQbNz
	c2uxbJG/UG4m+ky63G7dYETxajNp3xpviUbNpOQYD3cDQYVTWgKwuYkBvRs4IavsC07uS3nKvSq
	ZXRzvB0tj2sT6ixoNg4cfQh6WW9PdIPoo5GdbR69xEZBxlI1rb+ECyu30fHaVD8L6zPI07rV5WH
	W+nVlfRqiQoM7uheLECAEFxKU70hkRuBvHgAzET2ylhQnR80KyCA4qr8oXkROhAtKSJZI77hVBq
	vn6FN5awUsiVsf4kL6xzTPmIW5/ATMWGtDV4MjrreIHK5/lTe/7AZRBLqz8I4ImG9OnfspjC3AW
	yUWoH2YH+f2My2H4NihoPEqj6OkfON7UTU4k8JDZSqnZrgghEsH9JaQybAY7uqjRDpTFIAKhe1Z
	NxmdINDkUiuevM2YTLEY9Z2sqqr9BzO6LLq883iqWfgDm40Nwmiti96Ei/oHa/mReZFTvr9Y9sB
	vHwOyIg6XnYZmB69w8qrziuE4l7wmif26twPmTi9oW9oU0eGprrbLPlJtnE4UewrvSqb2WUPNp1
	pI6bRvB5A6CAvrKoLtpjc3/kKchMMUiKl5xeMAXsZWAloXvS7WH/yM8uCao8YI9AiTx5/QKkyqR
	2+pZoyMVdlLztZjB06K+4Z+EaExZVNt+/8VVz75bGVH/0m6zGJRX17nAe7SVtGL+yYzP6TIABGj
	3BO2j5KOOjrll29wl1KDLmyajjtyVV+UL220bXrMIJ8T6Mod6TJSdqu15ZRa683v+jXTWSuwv1R
	zL/8ihG
X-Received: by 2002:a05:600c:1907:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4ac16fa15edmr47984785e9.0.1793364735508;
        Fri, 30 Oct 2026 05:52:15 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-a479-65ed-4521-39bf.rev.sfr.net. [2a02:8434:fda5:4201:a479:65ed:4521:39bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723cdsm3170047f8f.12.2026.10.30.05.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:52:15 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] tools/bootconfig: Preserve paused histograms in ftrace2bconf.sh
Date: Fri, 30 Oct 2026 13:51:51 +0100
Message-ID: <64093b335e44c4233947326d72c96bdfaa9954b2.1793364709.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793364709.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com>
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

The trigger file reports a paused histogram with a trailing [paused]
annotation. Removing that annotation without adding a pause parameter
exports the histogram as an active trigger. Replaying the exported
configuration therefore enables aggregation that was previously paused.

Add the pause parameter after the hist prefix before removing the display
annotation. This keeps the parameter before any filter expression and
preserves both the paused state and the filter.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested paused histograms with and without a filter, plus an active
histogram, in a temporary tracefs instance on my Ubuntu machine, running
kernel 7.0.0-38-generic, with recording disabled.

The original exporter restored the paused histograms as active. With
the fix, both paused histograms kept their state and filters, and the
active histogram still restored as active. One filter contained the
literal string [paused], which was preserved as well.

 tools/bootconfig/scripts/ftrace2bconf.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 6d36219eb997..93879181dab9 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -114,7 +114,8 @@ per_event_options() { # event-dir
 		DEFINED_VARS="$DEFINED_VARS "`defined_vars $evdir`
 	fi
 	grep -v "^#" $evdir/trigger |
-		sed -e 's/ \[active\]$//' -e 's/ \[paused\]$//' |
+		sed -e '/^hist:.* \[paused\]$/s/^hist:/hist:pause:/' \
+			-e 's/ \[active\]$//' -e 's/ \[paused\]$//' |
 		while IFS= read -r action; do
 		action_cmd=${action%% *}
 		action_rest=${action#"$action_cmd"}
-- 
2.53.0

