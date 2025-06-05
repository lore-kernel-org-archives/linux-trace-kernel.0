Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F3A32;
	Thu,  5 Jun 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749082015; cv=none; b=YShlpIBe4xRFN304Yg9DHRaZbTfyXlAfqrvLRngGix790vRGcw7qVsyC38Lv9NYlVwCtg/t5VCEQUPtWs8Rum//0xqn5FRWRDmRXhKSBM7sKX7XOHjM/vs9V8Vg2YawKPgA2wxBaSVj3Hp3GYa9PDn5jQPLIQrbNs0AxsLlK8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749082015; c=relaxed/simple;
	bh=0CCPwPznTo8e1C80rD4v5dfasdzjtlizNqRqq4FZQd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hihBpT204b07u9nXWEaQcUjLOll8u0KInTx5dwg/5MtPbLEY+5DwRR/fW5NL3kS/FWZFPcKFLrZ/hCbrucY7hBAn5xC19Pc0C7uVQIeYzdprlgnjSg8jVx87BCgvC8Ns8Vq3iZX3QK+V9ILQMEaHYi4WBJZXr3ZJKY6uCtFClks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juQKESK9; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juQKESK9"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e818a572828so146825276.1;
        Wed, 04 Jun 2025 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749082013; x=1749686813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYGDWZp7STe9epYxyRZPry6LWZ2IgWRwn6tFibdzSAI=;
        b=juQKESK9laPJeM6KQ50bS6f974JD81a7LZBeQw+mUoFQiYbonlplJOyuH7FwU5VI/h
         Pv/wOpolRDJml/bKEo1/sA/V2qlQ0KNoMwtlvXXZi0Lu7LNWlZP2zGx79Ylzi/e0BLvn
         5V+ieCmhdW8p+0mUP0rIgwdpPycRQUE2BX2pUrArRA+jBMFHgV0JDUOjV0bw/uIH5WD7
         c0G6Zx26xzdCvfQd+ikcea9Ip1ihkTarV9C2Bow0AcNMGal2Vcy0UKbABURRdZgDyLVv
         pNfAcPvDNOdD06Gy0TVZe/O2Vk6Ti9WCpUllbB2PWO2wY4Cgo5Emot82vo9xdAD7Q7K8
         9IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749082013; x=1749686813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYGDWZp7STe9epYxyRZPry6LWZ2IgWRwn6tFibdzSAI=;
        b=d8mNLqrN7N/I1w3NGNZ7YV0Cxw2qYeo/I+dYIFFZmoa+DvmzDKxpFVeDm+QkTPkvOm
         9vUJ/CzhjHfFOiImCTeLZom/hWl9SthM0dwo0WSi4ZZQPcF3jDTvFWE/u5mN+TrpXrFn
         1y5G3XFCmAo0zdV8fx3D/uujZ2PS5IxcteNYpzSRUEns/m0gKV4JplOtMkGIyp6FRQ1G
         gzYmLP7O6yC+s8ahyycX3zkR6y7kzIPm7oWttnF7Llgrl8b0LtbhkWUV2tKff7iuITJd
         jk2YpBua9j5MLeA9jTK/2UktoCztjcj24XGwV7dF9B0O70eyzoaEw9uOvYeKH/is4NPi
         4QGw==
X-Forwarded-Encrypted: i=1; AJvYcCWmAdR06aMIyJUvnDcks8vIHZ52lHhpAR66X8fNo/3HYnRs6jIsoFKuMoKq3a2HS78+LlftG73g2ich0Ps=@vger.kernel.org, AJvYcCXtJli/Z+srVtYGwwQjiCdQCA4LUXdJkubK/y4YQDGbk1SCb1iheT39vqfF95WXNUWZlnrqKM/PgG0Fe0VW/lbc7wsf@vger.kernel.org
X-Gm-Message-State: AOJu0YyVK+d8auhWKYiaUNR+DyzxALn3IOPpwmv9C3XNyVF6dbvcj5gv
	/HmOEpgKoB5byaCRV1a0ezg34X7+x2jPL6oV8luqOMnFlRelf2oD0Ubp
X-Gm-Gg: ASbGncsPLRWThtvCldt0VN73969MUvKp0x6x3hyMrGzH2UjFt6qvmZgWHG+OXWMPSgY
	Pd+T+H7BLMY4fQpvxjRtRfDAHWJc+28z7be+obS863H0lxmNWzCXnJiNQX8HWtcsw6zyMjSTZNE
	TGwqvd7gUNahI7a4cQqyAxB6cckTaYwj39+ECyXT3DUQJJ2XZ68muwJWDyWbY5allaTPHa7v7S/
	cx3PZ3u2Au5wJR1e3FRMqHjvS/NedwHp2mJMOvbB8fEZvrbuIlCNysdAGDUiO6BYKpewS9Mq8fr
	1EpeJ+y5WHD6nC7+1KTTxGPCPkf9mwueBCRx89F3tJvOua+gaKxa8Y+Qbyd/Gxd0+ADUt9tNQ+T
	TzlbuN3zcAyo=
X-Google-Smtp-Source: AGHT+IEaTT2Odqt9s3aafh3eYQkQCU7ibTz4//UO8SfwKYgfxswGGtOn96hF2VfXOqO66zZ8OHpWnA==
X-Received: by 2002:a05:690c:6705:b0:710:a35d:1de6 with SMTP id 00721157ae682-710d9f35e08mr63781647b3.17.1749082013152;
        Wed, 04 Jun 2025 17:06:53 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8abef114sm32531027b3.29.2025.06.04.17.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 17:06:52 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] trace: fix opencoded cpumask_next_wrap() in move_to_next_cpu()
Date: Wed,  4 Jun 2025 20:06:50 -0400
Message-ID: <20250605000651.45281-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dedicated cpumask_next_wrap() is more verbose and effective than
cpumask_next() followed by cpumask_first().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/trace/trace_hwlat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b65353ec2837..2f7b94e98317 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -325,12 +325,9 @@ static void move_to_next_cpu(void)
 
 	cpus_read_lock();
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
-	next_cpu = cpumask_next(raw_smp_processor_id(), current_mask);
+	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), current_mask);
 	cpus_read_unlock();
 
-	if (next_cpu >= nr_cpu_ids)
-		next_cpu = cpumask_first(current_mask);
-
 	if (next_cpu >= nr_cpu_ids) /* Shouldn't happen! */
 		goto change_mode;
 
-- 
2.43.0

