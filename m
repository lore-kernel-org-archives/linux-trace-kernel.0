Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795867091;
	b=k4FnNOSsbNv6pfEH4grCBMKlLXIw7O3KjJqs1BOc9M4O6ZohbF+ZJ8Cj4opuDbkhQebE
	 JFeoJTiuhQx9WwAmCkruFFENGxn9K3wIGkFSa+6nWvliW3XXk6e8mcMfpw/xematGWbY5
	 dD7NnXtn95IhCX7V/l0ulS4JyriG9Gbqp8Md66vJBtDccqYpUbzVxmgsASOCejwSg86xU
	 VvajU/wyGLrQdYulfdt6ZEfvJjjHIiW0IsD+7/4bnj6qshG8Fxns3LjX0Np0Yy+ubYrit
	 OcoP+/3qt+AMx+uU+l8Y54GdERLAwwce2MUApgJnOUEjGJCk+VMQrX0dV/IMrJy/ECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FpvACcdQhl/atTKv4DKgCKM1m8xmn7nYqbBKYCKvCEU=;
	b=2roDg3VSF31jyZTLv2HUP8QcDg3UfcbKeIvMOzMpnr/JH/vGADTYabQhalahIbSAiFz5
	 ICe+ES+7ExHS/VvUcsZ/ToF8xo0zEGDs9NVzJ6VRYIPgkSbJCUDT9aZzgC2jwy7yVDG71
	 7YP4zAaoWfGlVtPf34YdxS1/ZS3pOnz9jKwqZFKgIY6meCV/7x7OoCqntJVDlmTw76e5j
	 xHF1566zE8fvDfw0w28woPAA3Wvr1B3eG4Cid08wSdw4sl/3YKlfiiARKjynSvwXjNVB7
	 QtMdKvyZs1kvPparTDOLZHv/FtWqd/mfq+m/Bapnja10hJbOSxaBCXbxDlLm5LvpuMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n/31V05L";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D316606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 11:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D316606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n/31V05L
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso63632645e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795867090; x=1796471890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpvACcdQhl/atTKv4DKgCKM1m8xmn7nYqbBKYCKvCEU=;
        b=n/31V05L2uonUlkRiy9GlceLTa7exdqDAIw6icIAVYpcchhzJT3Iv/qTBOIRfGtwE4
         zHR12YeRo/y4QuLqYC0z50eyUwCFavT+Bg3wCwBQhk0bNH+wO/VxLZDMn7HG6rUd209D
         JJyw7szt/O62JBBCvrwpMds/9OGeXFva/mp7UJfQDqc+O727u2gveS7v+GA8zoCiyd2d
         ADvobh7ZT5uKfH1ErqLQlDhqnL9xsjzti7XvTpJnrvDogLn0mkLXMNMypI1Fu2ZrbYTK
         lGs7+SbxXdOFmjpZ8xLJbOJOB5bqm6NV/hehomPzoU6/5zCNTVQlkIiKbPZDrnGopcUO
         5HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795867090; x=1796471890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpvACcdQhl/atTKv4DKgCKM1m8xmn7nYqbBKYCKvCEU=;
        b=NXuHTzx88lxfTNo1oQlkaFf1tZBR0+aj5bdjU+S8kmQA6BRqodN5AoR0dJmCk2OElC
         ErNF0F9XObiDIhS+bmXMXRIypCmfyKaIdbjGEoqDEpsW4qQXyuMAmDfgNylmgVdw2Dmo
         Po9cMAeedxFEy/KDONVKJcIDT4pfd/mnrq1luZFruoaY4A3J2LoqY9iZJNwn9PZOBNQr
         TQY4EB3kCmKU+i8p/OJQzBCLiaBmaLWk8hVvqCeb/9RsVGcjc7u8xpshr6RroCMzUF5A
         K70YXT1/6NeibIRt5qrG7/iLQP1jzM/7NF8yA/T8IenZB5/4faHoI8+qxIHin63UmiGC
         DFhQ==
X-Forwarded-Encrypted: i=1; AL+hErFoSzz4iaqiyoRMQH64UqMrXJK/JfHDmYGBjg6wWkA9DuVWhxhitVQBoetk8rGONKimOWoZRYvM912ruzp1ZZY5cn8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Zwq9w9d/EBY7dhPTiRux4SCc+mzVbk6fbkz4rQ1VkAo5Favs+
	nCqba2obBRlq533DRcjkskEOQb1jTYGxkSO2+RF48sV3zBZyhUSved79+3uQEA==
X-Gm-Gg: AZFdTZdw8eNo83uV7DjFcx3Cg+y4Rxz5E2mHetZJUgjSkcpIQb5HwA6NvMCseTW866l
	CJ1BzSlCrZ1wY7GxcimNiPmYSv/cC9S3999Coog2PYhpjAzPe2tz5RJatSSFaG1OCd80ZR9Maql
	lAKgaIp3o4Dr1uF8cqs/CnmrRZ8YJ79TJsq97P/lJbE4CqkPHItgLQtDfmbKsA1/00AZAWWoRVr
	IVIbRYLPAs8kpkL2eMQwq11hRbmVaq2XKv2Xs6YLszKaaNVDokMO5NC2iA73DqjVs+y6t4Nwjmg
	d6kITrIOwHXaNio92qc7N8m7FApHf64WebXBvR6j5+1F0O67ykhvUJVgtdUDS1drWLoQKntv3bS
	Gyq2B2jMAtrdK9rhCQJQDOVSMElzFBT8oDEUnNWNV+NJboTqAutVnLkZ0A65OQ21LBXE71wGK8k
	rs9ztgCSizOrmd11qy9052hknINeATPHtl3CN7Fz8PJkihlDvhVgHKmgNDu9uqxNaTRkmc3AOp3
	8psAeIpszbTYdUt0kqtjr5NMAe3omyFG/HEdiqmfJc84pU2hZRNSLmDFh8Hp9U/kXPRDG3/FX29
	05bLs3gEkjQhJFwehFqhxoQdcaYPx7ZYNdg+eFvGwdsc3ogFVne/1xbCw+dAengC1FOd1qQFvC+
	I1pvE9QM0ZqOVyhrpWWxUcIRIjo+aMtWAGmhrRHCyG70k3wYP8eV3v+qPeAd9P3Gp0iCyjcuIXk
	Mw08mvxb+vLmyUCWSEL5Z0v9JwUPz665VM/n8odeOgWiM/LDCxTwV7e7zQuNxiCW8Ek9rmZij+i
	R9eXhDCJMJXgGQLig==
X-Received: by 2002:a05:600c:4504:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4bb888284d7mr574263115e9.31.1795867089785;
        Sat, 28 Nov 2026 03:58:09 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-510b-18d1-bc36-7cc9.rev.sfr.net. [2a02:8434:fda5:4201:510b:18d1:bc36:7cc9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm832768435e9.14.2026.11.28.03.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:58:09 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tools/bootconfig: Preserve event enable state when retrying histograms
Date: Sat, 28 Nov 2026 12:57:56 +0100
Message-ID: <eeeed6cb5248903e64f6be45de79ceb3c7f7909e.1795867077.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795867077.git.edumucelli@gmail.com>
References: <cover.1795867077.git.edumucelli@gmail.com>
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

An event with a histogram dependency is exported after the main group
walk. On retry, GROUP_ENABLED still describes the last group in that
walk. If the last group is fully enabled, an enabled event in a mixed
group can lose its individual enable setting.

Look up the group enable state for the event being retried. Still
suppress the individual setting when all events are enabled globally or
the retried event's group is fully enabled.

Fixes: 1eaad3ac3f39 ("tools/bootconfig: Use per-group/all enable option in ftrace2bconf script")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
 tools/bootconfig/scripts/ftrace2bconf.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index f62372adbfd598..b685dd6b070b0c 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -135,6 +135,11 @@ retry_unresolved() {
 	for evdir in $unresolved; do
 		event=${evdir##*/}
 		group=${evdir%/*}; group=${group##*/}
+		GROUP_ENABLED=$ALL_ENABLED
+		if [ "$ALL_ENABLED" -eq 0 ] &&
+		   event_is_enabled "$INSTANCE/events/$group/enable"; then
+			GROUP_ENABLED=1
+		fi
 		per_event_options $evdir
 	done
 }
-- 
2.53.0

