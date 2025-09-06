Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BB1F8ACA
	for <linux-trace-kernel@vger.kernel.org>; Sat,  6 Sep 2025 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757135185; cv=none; b=amYFB3llLHXcYBF6Kg0TnNDCH/0PleWNzzQu9+AZ39COzFi8PrY1ZjVZvFCLFgPu/H7/4fkWs2/FlsQFlMxC44efV0kowB9Wenu5qoQso6RgT4ta9nONemSfUjAqRJoiBoYfO0wiewT7VoZ0o/90mb0GJqDxlUd0DXixdWFesoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757135185; c=relaxed/simple;
	bh=lMIGCg67dQRestHSbslZyMSSzVltNCYpnp7kdkcFuAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPxq8+NyMJCFgzmRY12sSnjejhSc9iphBa9PrIRlQ/ZMSYl+7phJVEdZ6kuEZNWw/Ee3AJrcNrriroilkwLDy8CP/9pQUdmgFCYVcmwUctxc+yY2r7SXOjyxVa+0IonXIb3LFndhXx8rL3wPth7KdOO7T0AGp7fpbga7V2Sfr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2+Bn1G2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2+Bn1G2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32b6108f2d5so1963255a91.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Sep 2025 22:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757135182; x=1757739982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru8avuXs/R90ukghllw5qlJuMMWMgjECcfabxAV2/kY=;
        b=k2+Bn1G2ncfg81tdhJgl22wQ5w+BNZlur44gQ5epZW0QydCq9vjIpDH/fLCRAva+qS
         X1PgdC1CspbxlSTJZb9c5CIiFdMzN3M4C9Ujovx6saIXtfXEwcL6USU+7syBFkTqDo2g
         4iQldziS4PKnRgR8Svj9BoQ0MMolW6ZSyUR1Fh4EKGfmnaHf+5eRK2cBBSUtSsEJYHK7
         jZrniu4L6LsYeN+/PcZr5ZYudNyN4glNSANr/UA4OAal2tpzkhufEEmioTm0+7204JU4
         Ur0UbJ4VczlWvdxj1NmxHEWrwPUhvBVPBgqTvuzFHhC+fM+UMSkKVtUaLeIAl+KBrg5s
         lkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757135182; x=1757739982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru8avuXs/R90ukghllw5qlJuMMWMgjECcfabxAV2/kY=;
        b=jSHlEaCdvXaSYZnnHLibLMaeeB5DI/FUSQykIXRIxYY9K4A4i/ppTv6TC0mLLlGT3F
         870HDiJQsPq6e1YIi+AfXxxjdciGvaPvUmLLgu79fLuHfBjQ+8aR+vOfjKhvBnKLp0yw
         7spIE7J4sznmfGKYF/5ZquhYvdoOBk6ZaVKG46OTP7J1IAvosatllxxYmf/HNcT/PCSQ
         xmYlsGswXLFLWzvO5/Rdcz/UozNJ1WsAYYL+CaNXt+IcPS2qbAiw14kNdCXGWHaXAC/1
         75Lnd7FEamsQ9eNbHpxXo1PXpnitX0xvbkLoxbfeV9vtE2rwE+KpRtNP0UEyiza4mIlD
         /Dsg==
X-Gm-Message-State: AOJu0YzV4DtpUWpzEtNcDaLKm5rlrXAdaa4IbCFHoX/EmBzVYCtZdZAt
	B+SV2sXhMCAxa50yCXuPaScYjZjwTeOu888TkRtOGmPLUyUOaAyPApd5iNy4xMJ1
X-Gm-Gg: ASbGncuEm7Qyk29tVhf2OVdTxdnD+XqrsATQTTwqkln8skPLoes/W8xeiq3WX1q5h24
	EvXSpE7cH8NtXwr7/iDFOnrZDpni7kiWOzWCuLcA59zHAeGs5SoTHQgidHRC8tyvhOQkX+93SSR
	v1qcnLJ4o8YJ9IC5L/V93m9vPC0Fob34C8Eh1mW9qBaIqmgT06ps7yDynteDnuF9XpOsLoj6aQe
	E9OYzQm96Av0K/WVYZWivdCoh0PfIIIBUpsOIDNKj3wtjyJfhsa92+KiQuv6+if1cDQb1ULCNL/
	9BxMiD8bARtsOEws4NaplluCvpr+tTF6Lwf/ZxKW0UCl+Zfd6lR017r+x+p3ODOCiqM/i2LXCIl
	LX2FpinwSs2eMAqiK3PHZkrHh6leon2aPGms7c2GWK8HnXQ==
X-Google-Smtp-Source: AGHT+IF6laCY5wCJ55XTDzLnx0QnDaXMvUQxwHLrOlH5JQSqKcnFEfdu+/m48NASOTmF9Zt5atgr4w==
X-Received: by 2002:a17:90b:33cf:b0:32b:9774:d33d with SMTP id 98e67ed59e1d1-32d43f6658cmr1478697a91.20.1757135182511;
        Fri, 05 Sep 2025 22:06:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b9261b835sm3080794a91.1.2025.09.05.22.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 22:06:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Ye Weihua <yeweihua4@huawei.com>
Subject: [PATCH] trace/fgraph: Fix error handling
Date: Fri,  5 Sep 2025 22:06:18 -0700
Message-ID: <20250906050618.2634078-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit edede7a6dcd7 ("trace/fgraph: Fix the warning caused by missing
unregister notifier") added a call to unregister the PM notifier if
register_ftrace_graph() failed. It does so unconditionally. However,
the PM notifier is only registered with the first call to
register_ftrace_graph(). If the first registration was successful and
a subsequent registration failed, the notifier is now unregistered even
if ftrace graphs are still registered.

Fix the problem by only unregistering the PM notifier during error handling
if there are no active fgraph registrations.

Fixes: edede7a6dcd7 ("trace/fgraph: Fix the warning caused by missing unregister notifier")
Cc: Ye Weihua <yeweihua4@huawei.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/trace/fgraph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 2a42c1036ea8..1e3b32b1e82c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1397,7 +1397,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
-		unregister_pm_notifier(&ftrace_suspend_notifier);
+		if (!ftrace_graph_active)
+			unregister_pm_notifier(&ftrace_suspend_notifier);
 	}
 	return ret;
 }
-- 
2.45.2

