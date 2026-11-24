Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534169;
	b=FO9vfrvRUumplnG34K7GmSgGGAM/qwjA11Pd5C+1IS6dlUwg7/yJ4Oa1CG9ntpoDoxzV
	 vkWXAjPgySSgBvVADZrPUZyX4Bx998J95cRjd/ZpuOHGGQBoVZydyx3pNpoB6OOi8PesR
	 5AByXxlQy9OdY/zBbXYVBj+ny5UaRimM9ZHLVCFVLyWS0S5mWFem8drngSrmMAWiFwtQM
	 z/lrW022HEZebekt6BtamelrNl2XyXk6wdAtK3sW4dVyFLbK6zHZBPPg2kXsed+HPgWBV
	 v85kuXYJ4F9CBfLTgrpkxNSZQTDby4c1smjPpMl71decCIVb0y/g16O8vfj0uMHbZvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KCmmFYGZgx+JwvyRTb8zdRtAiUdIEZ77HMLwsBCfOrY=;
	b=crQT15AKP0EwHkC2/CZu5WAI0hnU0u/Am+l/whuZ5fx+rCzeY4aLiQq7eOyMkZYsIBDS
	 lMabiu+hkliehgZ7+bVvkFci6pT+pBIOiAVDFAQx1oCtLB80f7vAFMKcyFSptJVZtB3zW
	 mKuWUQ5wWL3L+KnNt5sZ2xAOfVKBPZ1jgsnkDMeU0FEhOpkEY0N06XQtYdxOCX819YGyz
	 8cncvP/Co5wpA8uvLvqofGAsqVxtM+zIE6j6ZZMubTP4UtriSynJdwhwGlDegwxa4cJ2n
	 qAOllsvADudlC2jZe4KmcCm4iPGHb+0u19LPEqbgX23b7TkdUjEQ4rMXslR2pVtTy1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P4vS2nwx;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2B60A2609
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20D2B60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P4vS2nwx
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49febef74e3so39420075e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534167; x=1796138967; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCmmFYGZgx+JwvyRTb8zdRtAiUdIEZ77HMLwsBCfOrY=;
        b=P4vS2nwxWayRhsGlY+OO6p/RgeHfIxKhAUOwXiD07f3eXx9VKtPq5mh7WlX39CiwhR
         rkBR4YrFTIuiXqxclJoUcvCjqGE8f5eJ1z471DDG3IJN78O4iJ61Di7mB8bxj1BieAEF
         Ler1nwXkrPA6WQcWsT9vekISkWvJR1gPERxcJP+ewyfRnyiQyNERPQUIM3RVsLLqw0IJ
         htO1uByQL6abgc2YHFqSsQctNMjzhriWVUQirDNALRoZzzxvOnTqnRFEpX40UhD80pEb
         t9SP085/H0+QdasXEgANuSmzmbeaIrNzeuWawdqiV83Qelrn/m0A302lhygOQR38D92W
         lCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534167; x=1796138967;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KCmmFYGZgx+JwvyRTb8zdRtAiUdIEZ77HMLwsBCfOrY=;
        b=UXK+YLTSyXYbqQ4eWzwaKMaZ/Kl303UOd/6ZpWO3LxPOSJMb5gnRFP0qkYqZpHcuBV
         2+ORqXAyRm5zbM5FcWx3jSQvBaWWl1575RzvJA9ZDoBJcKk+6EGpWMxbpQcMatRS9VcC
         AZbRSZPBNMus+1M+nnpHtHUIORTjYmXNlUUlQUWOjtcigo7X1i9EDqOfX4UQ0oDSF8Va
         miDFBbOcxo/DFVcHmya/t5TYVK/aPAg1PvqGJHfRNy2LPlR5Tljj+b6RXF49gg5SgsHI
         Nwf1Woq/0Db6dRkJgq1mOuWcUHxLFhDgyoYS9+Nlt4ypUIYWqBVk+7n6nYk1vXI7Yd7c
         sOkw==
X-Forwarded-Encrypted: i=1; AL+hErG/4chbTVM3tB56+xld+FzCJG7a6Qex5clMNH/yZVoJHopiJOrdwPbttU43FyQWi88kzGiepQW2P3Ti6RZnowblLfw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XoCnTxn8CerVXVipOHqMcbL5bGD0InEZqT2w8tLoDvoe8nkmT
	AXORe7+ZygQAm/E9QlAehqEyD1WI04sFQ9r9HGKUv6ETG4Gg68PfNEeBF27R3JfXRLp+Vwu4ET0
	Mu6blE4X0USIqULfwkx8w1g==
X-Received: from wmmr3.prod.google.com ([2002:a05:600c:4243:b0:4a3:5d77:a650])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr307171115e9.11.1795534167302;
 Tue, 24 Nov 2026 07:29:27 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:34 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-11-vdonnefort@google.com>
Subject: [PATCH v9 10/21] tracing/remotes: selftests: Prefix hypervisor folder
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename the hypervisor tests directory to "00hypervisor" to ensure they
run first. This prevents the hypervisor tests from being interleaved
with other remote tests which is confusing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 .../test.d/remotes/{hypervisor => 00hypervisor}/buffer_size.tc    | 0
 .../ftrace/test.d/remotes/{hypervisor => 00hypervisor}/dmesg.tc   | 0
 .../ftrace/test.d/remotes/{hypervisor => 00hypervisor}/hotplug.tc | 0
 .../ftrace/test.d/remotes/{hypervisor => 00hypervisor}/reset.tc   | 0
 .../ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace.tc   | 0
 .../test.d/remotes/{hypervisor => 00hypervisor}/trace_pipe.tc     | 0
 .../test.d/remotes/{hypervisor => 00hypervisor}/unloading.tc      | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/buffer_size.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/dmesg.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/hotplug.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/reset.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/trace_pipe.tc (100%)
 rename tools/testing/selftests/ftrace/test.d/remotes/{hypervisor => 00hypervisor}/unloading.tc (100%)

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dmesg.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
-- 
2.56.1.809.ga0b61035b5-goog

