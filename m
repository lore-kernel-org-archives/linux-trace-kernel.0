Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158309;
	b=ztplNW9VC4J8wRTk9aFGiNut36bFV2yzh9A+H64u2JNmj1+0ZSOcNq/V+92gKUjZVmnj
	 E8E2GVaBb9lXtEv9B8L4V5QQrm0327+vtEKUOiVrX4NMAQL8KSB6K2mtfhHtZwZi2nken
	 +CLY04AkKHKFJaJ/Y/WxJV9p2Uh3gNYqiiDhbXsG39Zs4oddQUFPhHjMpSwtO6yeNqiyu
	 RRw/RzDaeTZAVe54ygUsKrosH5ONoktcfJUmlp9CdTNGyUSMmC6aqnJMQOSMhfsNQTjBT
	 9THtq2AB9BqeLxwHcG+9O6bbHwlTiyNVdVNm8jUyjUHZ6fe503Z9PCM5M3jhddWAedA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XMTbYYVHlMzt/kOSKupfitaPTvvxuFfzu7jXp67o424=;
	b=zz7WU72xgyLsG5ZIT53afYT39r9hQZnxXUA0aKbf1FgkKnpazjLlXnvSNJ1BA3r1zKYN
	 H9HkSv7dgcBaTPuaVT0MvKDN3HGRVqXyvYNlfHqTFwU+L/AuaJHMi76RWMulit4Kc9jBf
	 ZwtrNw+hqEiqd6AM1i+AvEXXe8zGtEtmC/y6I0O6UFPMw2h0IBQ0FXz2Oxoq4rPlJdRw1
	 Fx2FDazLNhNtvnUjWuLFahR5+H0Hvs8/lf4a2ze76z4YwPOHK/V6Cqm2IEu13RBrcz3yZ
	 0iNij5AJKcWnQWQIL9lPte1Sag56McCSM1eGRjneyffORNP7I9EnXGxQz190LWmn1Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBKeCNf5;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14A606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 03:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD14A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBKeCNf5
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e04773687so174892f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 20:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158307; x=1793763107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMTbYYVHlMzt/kOSKupfitaPTvvxuFfzu7jXp67o424=;
        b=xBKeCNf5ITTDcklqB6jjif7vTfdV2S6+gqmE3n+nD6xcvqqK/ms1k46RxlvyqTFTPR
         tg0Ok2ZPztpGofsrbFwqltnbRcBObY0jQ2oT7bcsJihnVn0retaP6WmYvZSnZRafJaSF
         lzyLC4cgf7vVmHVrhNe2lHXvKZCAavK4pVUVQDZuzJty1+0y8+MO92i2n+ZI9/LcRieA
         AR+uOT9Na0OlkKSbgnEB3XdRgG3YkGA1EJrtpIOmode+Ttp1Ops99NyzsrbHJ2J7oiVg
         ipm+uP9HWhXMDLxLU3Be7rLWH60b9UpOpalvYdsNG0Aj6oMjxel/K3CLNJhDAGVLQKnC
         PdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158307; x=1793763107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XMTbYYVHlMzt/kOSKupfitaPTvvxuFfzu7jXp67o424=;
        b=X48hlO8IScUswBYw/hyB2fQpTlKk28ik8lgepCLKEdGcVqSxRMEUp5RpQoCnfMD7TA
         Ul/RDYDmJe6J5/J+Tnmg5HGOM+STB0yQd/Sn050HOgbP+udK1vGbqK9Otr7v3kzPmmKJ
         uZBzIbzBFA2ZCbvCP8DkmX9S3JkF/WPpRcdFQI7nVaVqxafgi5QZyqA2Z0v91vZUb121
         fxtOw6a7U6GiXFPAcJcWIQgyAHX2VMLZQnbq51cfbnZvo1z+8XitKbvd/4WNAE3gWdNv
         SLbgruPsLaxNQT9WhPwBcxHYIQknH+UVFh3ans/YDpHh2VDfCOoXM6DlLgsTUTv0tf9b
         SMKA==
X-Forwarded-Encrypted: i=1; AKwUvBxeN/hdRNh3zW6b5TqmqiCSDN47rw4lFZmL2PLjvzyVcmKrz8WXEd/MHa/iKdHfYRa7EUfKa1ZDMmhvP7pD5qnDgTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfO+CVfueloHRw5hEsyO/Ibrob6L+u0nT/HnUndqfLeyw/JUm0
	8b87ds4eKAJvw6v/1LIjpjOBNW9FtHq0YBknGIbMcsiKvM2boM4BlDdW
X-Gm-Gg: AYBFou1gnaHOXNIifl7Gihr3nxx1NHGO0xHjxLjTqF63QRyBIWKN7Yy4xa6QGL4LC3M
	zUkpwQAniZOUau4xZ5ATQIG6y6oH7aWlk+niAelvuEqYq0T/iLLp/Z+pW58w1IpX2xIT/d4smhs
	CNu4v1kMHcvzh2TxF3U0YBxgKWLBLnv0DScdc1LSHtuYZ6LNGQPjTMF1g2El6FqH1NUI59nkSkQ
	Wbc3RdBoGw7P4m+BAdPPcPr1Xt6gHU6W4YlJyBNTRxCACAQFWacCXxCg9IqbdPZ5OW9qVJPuwWJ
	GKbR6CbpYFNC3hM1/1mu6KdM1dULk/hQk42Cq5qOs4gc6YlR9oKdb/Ez0NIRXezqzREHKEUwgtm
	Xt+LJpb35eTVuQo1b+qz5161pZP77KWRVHxT72Kzrpgg6c0qp86jwTUDslqe0EQ7B0gB+jO8rRj
	/b7CBUw1Qw6hD5+dZYwsif5bn320AfcZYVD/HdTRuXkyvMwk0nfAmQQtmrA3wTiCPhQv6U6tnLI
	WE/ToWbCFspuaQ1NGTy8ejoDK2EiwlFFsBtDUoYWJ2eWWW868M3ZYknV54r9zxcml8yCNmUdQEu
	4Ti/gCcZumo2qltzQtTMbs4ttk4z6TpMOk0Ywj1CD8Desng0SwUecqghkEaV3MyHwrsDEcrk7My
	lNksEga5P8XGEUuqZbqjiPYruqWCcNzy1kBNS9/HO2rGFZvBkLXyiZvvBDTDnm5HUDfojivb+Ri
	MgwUdNntIQawrl++MpuqdSwyfuiuZjXU5Tt+sAowJ3r6jIU1Sx3o99Gg==
X-Received: by 2002:a5d:6f13:0:b0:48e:4e00:b737 with SMTP id ffacd0b85a97d-48e5d56d4fdmr2944765f8f.54.1793158307173;
        Tue, 27 Oct 2026 20:31:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.31.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:31:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [RFC PATCH v2 02/13] arm64: percpu: Annotate __kern_my_cpu_offset() as '__always_inline'
Date: Wed, 28 Oct 2026 04:31:16 +0100
Message-Id: <20261028033127.82193-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028033127.82193-1-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
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

From: Will Deacon <will@kernel.org>

Allow the use of per-cpu variables from noinstr functions by marking
__kern_my_cpu_offset() as '__always_inline'. This will later be relied
upon to detect stack overflow of the overflow stack from noinstr C code.

Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org
---
 arch/arm64/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 3cc316091d665..105f659bf8061 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -37,7 +37,7 @@ static inline unsigned long __hyp_my_cpu_offset(void)
 		    "mrs " dst ", tpidr_el2",				\
 		       ARM64_HAS_VIRT_HOST_EXTN)
 
-static inline unsigned long __kern_my_cpu_offset(void)
+static __always_inline unsigned long __kern_my_cpu_offset(void)
 {
 	unsigned long off;
 
-- 
2.39.5 (Apple Git-154)
