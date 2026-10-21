Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551920;
	b=LddjLPt0g8BwSlQunt3gToWdWeT4yeUSJltq5RtRjN0LSuRGKV/1+ZbR3Rg1U/+BdBZJ
	 xPAsAVv9ou4iYHDgjiBrmGxvCJm7eJ4iuO4lxqY78YTLMfowWE16PSljn1iNcItK3fPYj
	 RbrtX6ocLypFbJk5XqsfKCoxO0M4p1Ya1ZPgQOxfU2TkSscfWX8JyvPzraab99XTC6nbO
	 /odOJgdWdbtE0g9C34Od4JZZGZch8KEeTtMXHWE/ll/M/vi3/d9v4tGPpVi/WwpKzwqNE
	 61K07eRFLhZ1WX34q8NL6zbPOHNqXpBKITFX794VAQ/eLm2/0/9rSrnO93VpLS5pjPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
	b=w2aZ4cb1fdvU8ATC5lT7V43wBSTMiRxNtrwfzIwbl2IdB/RXeuB1WKZyhIPHfS3mCv0y
	 fW579iDZk3BONCxleyDtyxwCM1GEf7DrvIH5FGdnWqMYwcZ7PNsCLuXq+p/1oHWRQek+f
	 W4BUMXvshF0P8srzmW/htaIsC+O5MzBVefsPyWLYpBpCy8jR8GLGFH7RqAHFqREXhq/t5
	 mxGLxmtjZEXOnxzOKiVDJOD5H8V8M/QKn0jUKZJudcQHNtWIFwwPI5HJdnZdfu1Q8HZTq
	 E0fwSA2NMxm2mAgOzU5v5MSPoaCdCEm0ZO6u9XEuEA3wavK+3+YQDPOi4R1SwpnTEew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTUhIXqc;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CC606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 03:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A01CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTUhIXqc
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd633ef819bso55929a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 20:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792551919; x=1793156719; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
        b=jTUhIXqcHD5paioHMBgpX/nNDFeI6GefwrBU5JCZ9L6hQkgDCCR5V9qDyK90TWxB63
         BUeHPqsNqUAWjxsKRzhiYWN4gg/2tWiSqAFA02QpOTMVZ8HDrd/73VlSzZ/z6Q6Zcjmb
         y/SpBz7FnPTQZRm1MiEuoSZnfDeQH8kZYfIu4tSt+PzCSc9QM3JzSGKAPbcRqH35wiGt
         iIVaNSX1r/6k7vkTPWGRrKb3k7KNyal3wwC2/NRW0KdNFdIthL0IVESKxGtAtYSu8Cn8
         cBxQ9fMunJcJn3KmG5zDQHXwvhba1VSFsi76J/0MovajXPhER5CLkwBZRb//TPZDUhXi
         dl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551919; x=1793156719;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
        b=IPsujkDP4Y+8cplaLDLgwHaU6yLfjOidcK951+VnZrCqLCdjS6Kariodf8H+tE9c8J
         HCibsOYthXPQn+HxYirNsJ+oswMItKhK09Qzennx569avbmfgGuqLmYNpRs9fK/4+2IA
         sMfxCxeLntnvwydUKtajY+qD7Dr7+hGrjAydV1NwVs/wBh3AeNU5M+ZeQG01PdPbT8Mv
         ktjcHaWI+w8Oa4XRsgbgwH1/f4jQQArN9+hxsPRNcgIV5Fe5QRmWJmz7qZujfZqfVjwi
         BUEGCZKlSXOy68eeT/45sxz9oqQ9ThSFDkc+q3Hh0hYuQzN8FTySvaoFJjbIBIsGhYVR
         PD4g==
X-Forwarded-Encrypted: i=1; AKwUvBy4jj7qul9zlE8jMllIuBufStz57tVRejlvs3oLktmrRBOCS3z/hATYHT4nFgy1U93Ba3FgApt7TTNDWrZcTjIlaCM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1dFcsvyoOlzMaqYie1eTNKCeXXmqxFmjUgN9KtiziCPPx3IYZ
	2Dce77Qr28+kRntEGog58QnQamOMP9rms5+9ergzFiewcW6qYL85IkXe
X-Gm-Gg: AYBFou0EmaOMjyrCHnU5T8vS/dtLNroKQATzS2WJhK9BqxD8Rj/7G7lOiy/GKh05MBK
	bM0j8dQNSWcaRJa1yhNqsLLHUQj+WH4mf+fdAjLwV1M0QHMlcIweoTWxrYPkUXdgtaGMFZDesLq
	J3zV230iM8GU9gSo0a4d8kl5Xlx5AN/frVQyuD2T4cB1Mgu1K6vlif2acRE+tIBqIMsiBgZolLM
	Y4UOA9Nxtf0NFoLDubKLweg/EX592lk1ZRJO973Ugv4bZ3czk12j4N4rvFpUgYg60DVjqHv6NFG
	FfZubpxDYyxCRPZe5Cben0eCOoTqX2F1466Ur48hh3b3MTenCQdeoQHY531caPpUfzpNeQShxxd
	Cct4KDrRUqxZ1wjjUsaVjoK3aF0gBjSv2g1aYyFQ+lEwGnIN2FmF35TAP+XLTUc2dZMImIbzrUE
	VKtwvP0HeOdf1yg9vcR3TjosIs/JucD/YHqVWHix96WKXSeigG9bhN3lCj9uSdw3lydv4Ukz7dg
	QZ0vqSvi4al5iGKgvvJ0Int75MnHQB4i31VvzvpxzAY9vIbODxl4z3Ec4C1tnAcA08VPzyizWP6
	4z2bMF2qSP7dH2gZbqT++TzH1j3q/OMGlWRrCRWa20Wfp9xGexw5P5avsm3I
X-Received: by 2002:a17:90b:2710:b0:3ac:7556:8ed9 with SMTP id 98e67ed59e1d1-3ad86c79924mr698658a91.10.1792551918978;
        Tue, 20 Oct 2026 20:05:18 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad812c565esm1924550a91.10.2026.10.20.20.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:05:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 03:05:16 +0000
Message-Id: <DMA6ME9P5EQG.3EI83DBIFMBDE@gmail.com>
Cc: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kuniyu@google.com>,
 <liuhangbin@gmail.com>, <mkarsten@uwaterloo.ca>, <masashi.honma@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Add syscall common attrs support
 for xdp link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
In-Reply-To: <20261020182700.655edf14@kernel.org>
References: <20261020152804.39863-1-leon.hwang@linux.dev> <179253001886.208021.6536312952037292688.git-patchwork-notify@kernel.org> <20261020182700.655edf14@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 06:27 PM Jakub Kicinski <kuba@kernel.org> wrote:
> Please don't merge changes touching core networking without an ack from
> networking maintainers. I haven't even finished mopping up all the ways
> the XDP link bypasses normal XDP safety checks :/

Fair point. Will wait for an ack next time.

Leon,
pls send a follow up asap.

