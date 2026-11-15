Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767297;
	b=3ilhOPY8v7JrGNz7w7AMTD3KdfAgU70NVrLVE5IDZMu7T2CGKEfeaUKT6Ved8TCMPsHD
	 eWcYCEG4InIMSm3FCizg1iLO79fJ46yWczcrKvnHeBp+V73WS7+pwg43jBz7mbfDA9EwT
	 PoKpRzvAUHeLoU8GagqN8SK4AAsxQa4q/Kw/qgJVHnGNBkt1owlzbnjch4bVxzLbwKOej
	 hPETsacIiBWnGQJ6xBVgBOvA2mcmprA3AAqZejI0ufrRCoGkuUtw+jiiGekIlVBJ33UnE
	 4kfLb6s9VH7c7xNxU8aqI16gRaGWSaDUD153xZNYO1PgqF5VR29j24K4UjLnhphXLnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
	b=tAvs+pOzYME1XZsKj8emcyq0P03ccmhnZ6mR8lf/Y4RP95NAgRRmf02d6u4B5HKoHcmp
	 oPZNnTDJmZ5iPLC6+5hJrex8zdPpmG9GQenD9ytH0JYQ7a33Xd+Xq6NXpZLZDIq7S1m8o
	 h7yd+FE7nmMM5RPC5CAUFQ15X7fPf8nKJDKWs/dObfyR9bfefTya0fkiui5ACtfggOA/1
	 iy/T21pXLA5F1h6ok3EACTN4qgxon56kP0Dr3oUldY4M3pqUA0xWbI6n7Iy1j7TkXuB5w
	 I3VNDBzRdA2+Khw0m+XyTid+DZsaSpLRXfSkRvJyGaWL8PCgAPAz1HxOt7/u4hGd56w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7EB606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 18:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B7EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1223948b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794767296; x=1795372096; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=HBV5nxYvdpLlRvsxsYLbFKr5P34f8mj9a/XJil7dVolrFQomVVkyecHxP6BgFGwDxs
         /19GzczoyqLC7fuxmwJyN2rwUymD2CerKLMnjfS/2CRMvt+ynLs5gkxwuVBuAu3q9J20
         IzB2wBplZLjMFwEGGW7prCWCSa7Aywa/5h22qXYWy2au5OKH6AKODohFFnhhSeGrFYHI
         n+FqPiDDYHHddi3JAW7aghC+X3tcMJhczYrIX5Hp62B1gpJjhhKWZLANouBkWkfFg5wA
         r6zaGmjBjVlFtwZxS8OaoxZbnmYU5uIROK1UqsDLBtdOM41dsZCnP9Jsrl/zETDD4H/q
         kP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794767296; x=1795372096;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=u5VKG2L88W/SsnJ9tVSeknq/lLqUMF2pAIAZ1JlypTO7HNPBtNx1vEGpfuu86wBQwn
         n4Hi4fJlhntRYQyehRd0o9+7YJWV26xuCYZgk7lxpeYEatkGMlr0fk9Rz1vMK7Am4qWd
         btRBOO1lfWUMK6EUz2Mo6yNAOT5tcc4FwjWnT0F7AVJ3GSCJn9bxKHFsnEniK4q8Jt/C
         AjY4qtMUGVTsgxmY+NhqSa/kYfgjShTbxk5iKMGyuylYs3LQBlze7OUsR6jdH+f5XUIJ
         MIgUhp12ThnvQpxOJGqlxcyhvmbvHRu/dMnccUWZO5MZpV7fH2pu2pBOfHFSet0oo/SJ
         VIng==
X-Forwarded-Encrypted: i=1; AL+hErHakCNVdGCpx1G3DZ5sJFzaKYcw7kk5puelB0L67ZTUakA5bNApFMf1E5is1jrCLkpMjyP93JRvxvRPnQuGKMemkxo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tSj3OrvMFmSTAJRgikLoPEfJpoj/LlqCebrpsRUlELbpIj8oD
	hJEDaYq1CspTs7sdOYxIK/oWqsyDFOCrjKuHY064xwJTLNB92Ic7Qng7
X-Gm-Gg: AYBFou2/KqB6V8L4wi17Q15pAIw6oTeburDC/MOHtEd/1AZnXGWsvHuyudYmQIq5wS2
	+xF8NMDvodPd/b4r05IWq/mCGguj5pTynv72jPF9QVSZl3dhp8VOyO51QEf7404sKQawNvOBQFI
	1H5sdSseV4P015YG5qkM+JRXMs1NAVi9/kxmEgTz5DIuGIwDPZhM6oct9bchQEUi0aFVy/jpYIV
	IlDHrNVvRncd7rzNmxiWZkrAmH/jSLl9TjsnzzFYNFiQdkXSdRDPJbFCkP+71BnN/BvZj6DrNDg
	UZnI8tTIy7gwuWPpMZvMgEDyBLOljXXuVPUyNQSd928hwxTiffmrFSQ2mPklemVlyycUHURD+OC
	y8f7HSj/jQYuS9OzUozbGvCOjaT3SfH9VAMl3Pc/GVOHJVcPkNvd3mfQNJHl9yqZwSRCPRL51zv
	vKQDcx3QmwY0WlaoAdq2Q6TdQUnk96JH4V5WP/WKcOROyQaeKctvp6ZbBdgyEXiI/N+xzEeIeL9
	bI/vD2QyBTwZih49dwe829FCQowZhA78W53bSn/sFcLGUrDzpxf4V6XPYOktIUpDFsHvo7L+x6Y
	U6p7wjl/shaNNEtxoP0WmpZKUyJ62C79Q+9W6fMHJZjxzS0Ssndwnh2TAQUbe1T35PNThe79rzg
	vCllI1Hopxzfh7fcyJ6SjmmFF6nV2qluItQ==
X-Received: by 2002:a05:6a00:230c:b0:89f:d620:226 with SMTP id d2e1a72fcca58-8beb619bec4mr7100607b3a.24.1794767295502;
        Sun, 15 Nov 2026 10:28:15 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcce6bsm2804318b3a.1.2026.11.15.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 10:28:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 18:28:14 +0000
Message-Id: <DMVZWOMFDBX6.3HVETC9L8RUEU@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Amir Goldstein"
 <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>
Cc: "Chris Down" <chris@chrisdown.name>, "Miklos Szeredi"
 <mszeredi@redhat.com>, <linux-unionfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 00/13] fs: let d_real() fail
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
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

On Sun, Nov 15, 2026 at 06:01 AM Christian Brauner <brauner@kernel.org> wrote:
> As Amir pointed out the correct fix is to teach the callers to deal with
> an error. So d_real() may now fail for D_REAL_DATA and all callers
> handle it: uprobes fail when they're created, IMA treats it like failing
> to hash the file, IPE denies and the bpf kfunc returns NULL. Then
> d_real_inode() goes away so nobody can ignore the error again. The first
> patch only drops the WARN.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
