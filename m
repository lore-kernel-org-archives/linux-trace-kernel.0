Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660269;
	b=ahjTJ9iVSfxdIL0dKseqYzxl9E9O063qfXTHrE92bAMs6w6rGEqiSRQ12U00jBpBF3p8
	 xEhdITj9AhEJb16H4XKOc7iFC+bd45yPKbCJV0aznVh3HeKQkdmIw8wr9zjLETqSOmWs7
	 bIUfiWL5daRNb7JGuf4O4ELIX48YtxrO4eJ5MXBYERpltMeG499A3YbKzaZ+rLvapcCZx
	 /zvjvO0t3oFUqzJDOcJZ4H8QK3M6qAB7qnaKOFUkbKqOWbMcg/hDW2DbQSFjMI9YYJTxm
	 vlZIJ/m31KRihnGY18QVlnRgWyUM8gOA1M5ulN0zJVXcDjzOo845H1hpzZKnCsDBoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bvbkF+FagNR8/UNuqVZVR2ljn+gIjPoOIFfVu2xdwBA=;
	b=3CV7jRQ7hYjgaIlrncogCm1vPFck9EsR6fVSXu18YjKiSkRV2wv4rMyPAh0/E/9TifG9
	 FedNfOAw24QZO/1eSfcv37ByZwDuzxgrojUtfu2FJgJ9KnQCBhf3zFbeZUBnrkO057jn8
	 mK6QnP3gz7CoYKBpO8wB6drqj3I2XyxT0hplLyYL6BfOTXO9h6Es5JCZRZPx7zNP+EL86
	 qeq3plQjurHcGl3CjvDx6o99n9M8bwMZzFpb21XD62I/S3QYN/YiT4sFVgR8kjD8lOaEw
	 hIfyUUH5X/nhCYFJubUt958W9YD5UCVQnGXPgLijgT5qFQ98l/EN96evssDp0airMYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzNwwYvm;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B8606A68E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 02:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A18B8606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzNwwYvm
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492f0a1b685so4528273f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 18:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795660267; x=1796265067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvbkF+FagNR8/UNuqVZVR2ljn+gIjPoOIFfVu2xdwBA=;
        b=uzNwwYvmWZxNpgCcjtkt0YmFb7NI05MmmICXZjjwC/0O6AxtaAM3BiO/e6OGFvaOJH
         s+doCeAavqTofFOTuEbq4c20WMtbP+srgUcuJpyWmpZWRnNTJXuN8ylZTBP/DHw+ngXX
         oRFShL4254qtph3HlSv8+57yciSxhFCFqpUPa6eMC8al7yGiL2uglhzvQ7hBcsZT+xvZ
         vAbyeR5sfctNVXki00JeJmujkGgH4GzXK/cy/6dzoqH8QVmYcTNxZpsaiKLzpPwJusq4
         QvE4f4PomUq2HPclFTtpI/nHNRiqvz5fl6MNvQz0+Yn6wmeZ+fnwwkJRVuHCTVFF1g2l
         2g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660267; x=1796265067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bvbkF+FagNR8/UNuqVZVR2ljn+gIjPoOIFfVu2xdwBA=;
        b=F3dC9M03vf8oekLuEseFipEmbTIgta04ZsMOzzmkrJBZmuFMG55I+ojZZkAiuCvBKA
         FnHGdGT09iwWZ82UEIfolIr9Wa8mAXxG4CQ2+OU5jDWLlB7UX3Jo+FifLmc5yFIpwp/t
         liqnqL0EHv7ou/t1jYrj2BKKCQHSaoGR8YW7onPDaloxsOCU8JK1yf9EuynSL/BroXnF
         SoPAYD0kurZP07lDdlmEJxqw6v3j4eF2B3w04tEftKb7CC7T+84HH+6ygzGoPlE4eMYd
         wofUXekcsXsRLRTayGdrHal8qHe7+KfH+UgUGiMA5nY2Ul9VSBpLDll7Pf9tYOYi/vLc
         haFw==
X-Forwarded-Encrypted: i=1; AL+hErHB4Wh03ZYki84GqhgXKGqFGYOAjLWCIpBKmxeYCx5SG3l5weQn7C+mGdjAzs6M10fv3J3X216qUXls68D1oGlv7Mg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mWOB9bBPVf+KSOr4AMhq2NfR/STHCMkEBHyfM7vz7UZmYhkVv
	ZfUoq7JSglnR7cW8W36fNT/J+t5z68BLPNv0caLcFiLOA0MIflhQGMvS
X-Gm-Gg: AZFdTZeLLFgwPQaZGm3YkRljqY59Mt9UAaCwRMnTSmn8bE2XPZpwZItGTCsf+ioNTe/
	xEGisOW3HgCwIiV7D/MvAqXYQbrJOgG/RTufTSdfJCHXTu9iw6Lf36iabQ51azUX3lF6eIscA6j
	P9/TvFHKyVCe2HzRiLkYE5AudMGExkkXMOa4RRJ7GlBC02SO+LudBwSrFIXg6ApiQByllWJhwfF
	PkwPTXF5cgZlPZKnNKcH5LQFTEUWCSL08w6sOTPmozgWlrclZHThiWB3BSUm742DsAbVtH4g8hC
	oJfJ09wmB5K26C/zJBZjmmUS9wpqKbqrry+b9K6IXyyqGz8dCKd+4HuJoPPD/RERJQwtqKhUou4
	lZDH0uaN6q9wq94q64zVlGiwao3Pbfpm32zrpi67I/G4leozd5ZiwdHdYs13eerj24E7GVvT4Jc
	BK535HbV66lAmmTWsmUQE5xQGmoc2hHQGVO8fidxYEhl93K+3oAtCacUr6TKtK+cLuQ6FO6rZdj
	xeAByMy3s0Z6ojpzTe7MGM53MdpXR7VYDZw4nyCCbk4fKCQEvnrj6VBDkat+rTQx8856hUPP7B1
	QXwUQ9n0AsytuB3U/DIl1pLHcS1Wldy+R+NPFUjL2iuzDuyeUIi8ZiKCC0goZFnSl4dQOkIvk9y
	B1WaxB1w6XeIa+BhEUKmlxcbceBNH1DUuZhZrDQwkHIycSt1kISFPoRdc4qTXJGvFS/0wHN62b0
	Q8/5o2VylS3Vh3jIPHGAh73GLUe3lIDaO3NvsC3w==
X-Received: by 2002:a5d:6f07:0:b0:48f:fcac:a5e2 with SMTP id ffacd0b85a97d-4abb47b243dmr35992009f8f.38.1795660266905;
        Wed, 25 Nov 2026 18:31:06 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b10e-d501-d0c4-b021-8d77-e472.310.pool.telefonica.de. [2a02:3100:b10e:d501:d0c4:b021:8d77:e472])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm37722445f8f.20.2026.11.25.18.31.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 18:31:06 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Hongyan Xia <hongyan.xia@transsion.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Song Liu <song@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH v2 1/3] arm64: Always inline raw preempt count updates
Date: Thu, 26 Nov 2026 03:30:52 +0100
Message-Id: <5ba8c2a33188f43f0b1d99d6ba97c8ea2e285f94.1795631277.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1795631277.git.kmehltretter@gmail.com>
References: <cover.1795631277.git.kmehltretter@gmail.com>
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

From: Hongyan Xia <hongyan.xia@transsion.com>

Raw preempt count updates can be emitted out of line by the compiler.
For a noinstr caller, that puts the update in ordinary instrumentable
text. Force __preempt_count_add() and __preempt_count_sub() inline so
their code stays in the caller's section.

Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
[kmehltretter: split out the arm64 preempt.h hunk and rewrite the changelog]
Reviewed-by: Hongyan Xia <hongyan.xia@transsion.com>
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/include/asm/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 75a592b7f47..f3a5c2cd193 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -41,14 +41,14 @@ static inline bool test_preempt_need_resched(void)
 	return !current_thread_info()->preempt.need_resched;
 }
 
-static inline void __preempt_count_add(int val)
+static __always_inline void __preempt_count_add(int val)
 {
 	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
 	pc += val;
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
-static inline void __preempt_count_sub(int val)
+static __always_inline void __preempt_count_sub(int val)
 {
 	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
 	pc -= val;
-- 
2.39.5 (Apple Git-154)

