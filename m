Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611200;
	b=r1MfxLb2GIhQzKBYVXZD0Mbkl9XAsxvw1EKqYOI5AeyfJMTsCbVsbGUET05Kor+eFDUt
	 Uk5r94zmT6wyCMBenqs/vIuwmpWQjZ0HybuOUAMpJvCdWnIF5lowjzm1IKyQyped9IRve
	 u3WYEDZeHqyaZHDo2B3UWlMsBFP6WnLu9QyZ3wuHRjxVPJU1RaKrZSkD0hSM8fuL+jBXr
	 MQlXgtOwJJ8ODBoycN0E0kcckXolDV6jBkKKLn2g99m8FNWccihgiFx/m5I5KhQ+BvAcg
	 73jWr9Xo+GzVBgsCaG1AMjzKFeeRWuhn6lELQ65rBRyW5KjeH22p6AUAnphnNGHv0Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
	b=iJNdQ5v5MHkioKO5Y+kotol7ssFj7lS5MNFeykEDhchF9DP5CGBy6gFLZWjOi/McItT7
	 zw+wpiSyZOuJOhZrxrdEeDbqk7b/PELD43GkZy/vaxJTVNWb4927EXwfDbdUr45bbIc2Z
	 GW9/GWVoUtcCXJrIvv8jANmA/59FxMG7Ia11PrBpr+9HI5qz2pRhyjrKR1cTz6J7ajDzP
	 7/IaNct/dYxeNYa8k2OrKBn/xYwmHvHvYe3hMezuOm/ZM4T2p6DH4o7zZd4v+xDMHK3Uu
	 seftxuRGeBrg6TJ7K6IYLZb8ZmC+NfUDydK1/VGq7jIIAJP1XJp7y/Io5KC8+m4P2OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0B606A689
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 12:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E0B606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso59426595e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 04:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795611197; x=1796215997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=QOXEZ5Pu/EPca6q7kzgJRCmLrmsoVFR/ZRe4q5d58yeOdbJoHTuz9y0u/Nmk0CktwI
         CoxL971qgH9IAeYEJL9OV04KK9hoZrCZxCXphCDmaMaCEIiYAFkXm9z/Jipc+urQTX/j
         Fk8I31Tuids+3mCeGda6Q/7DCnEHSLo9OC+CFzZ1uqDLrPjUm6OialCUSj83o9zL6oVG
         iksZBRXktSiMRqpVyhlcQqbeKVyrA1zYnXNdKX3aSHnLNR56AH4l3EmMwrecUL/g6kYv
         65m48YXn1HMJU4OXkynxAivRZrQT+c7z3fBFxX7gT5o5ijKHn00slucTC0ZtqVCasBEY
         yyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611197; x=1796215997;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=hAsOO913cojy5Oqxze32QGj9DzJqzd6c5PoBG7VhF9gQWFrATnlWzvWhERoA7Vq0Hg
         R1QaXjzurfv9wcObwTLvm/4YYzhdjHksf23k9lWebLBuVkkOyNE6/8lrYpKw2lQCUSST
         ZG+ALHl9+lPH0yHpy2YuLn/mYOuDpIH8Di98936aiplWZxZx2PuYPrGyXLIekpdLWVD7
         YetaSMQ5ZU9TcSXQAQ0NfYEpwcdkTm1tyd7zwLXuNqshVvAfSG+M3VdPct2GxuTgsVrE
         p/wW7UAiNZpPGpB2+NjYE3Z3ggRqppc3dZol78KsQSOiFkzjUxwgHDT6tIk7nPDWwirJ
         o+2w==
X-Forwarded-Encrypted: i=1; AL+hErF6M/9fQEOXp+5SOAxsScxozRyhlgnOlzLc9l+x3TELJIEbEH1ucUHYch/RdDlGG/vWsN+V1IrnvgTbJGpP7HHN/kE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CkgCZwG42qXuoDO3hFJQtDFLKEvLLnZoSADhYqCuvTZAZd9yZ
	cn0OWpl3JzP6Sdg65FdZVVDgjKRIuNvFY6heaF8goeux567KVpX7Fx6P94CUIsVPwSh9
X-Gm-Gg: AZFdTZdWY6uraPHmDp4l7o/0ochYJ/RoieRMX0aYlRCY5PLB+Eu7AL/OnksSoU5MsT1
	I6ecsyGGnV9KMVAg/jvlHWJ5O7vT4etX/Wm1Tjk0x44cJnGBDwu6eBPnbQFcH5crocC+M8E1RY/
	+8ZkflrFfqDotKVwQJNNH3LL/5x65QYm7qwjJi8IWrg/bYzSr0NuEkPpAcmDUmbks7Sg8Dm6sOa
	xGDcVwxuo0jWpknVV5Bp1KcruVLAuediyVqT/1Yqe0nByeFORxQsQhjAt3QWT7V7E044H/nNROr
	gqs5HG8AYA2TVzga0AcavVK4svAKHjc6mAWG8Z7TgFwguGdqItlhQAP2o5sKp2xhPlUJzdXReYQ
	kvSAOiOxsXIHXL89b4nJrgmEjzv+tLulxQxOQMTXLkGKS2yvvbswxr1zLa57GQpDKNeWLmwRhCh
	rExoU+LEr1K/srrlBagDzbXeyxZoLvilLn0l/IKCRHi+xBtv9X94qMOCJ2zAwMWfmNgdIqorp03
	HqFQbKIlOQZ8q26ESpXsR7nbk8dXnZ9aoBkPtsQWzkvlRKM/fxI97jqwOUildmtGaJBRYXeIOor
	Ytvot0ASeQTekjbrezPBDUwanyWVqEXU1eT8z50NTuwcUWn+36zjAqrKdy7GZwBIQZ6dpDhexZ6
	KiZJpwL21lFkOiyd7ypJ9rP+E9YXjvfP3qtxgTnvW9CejbHMruu3HHdAxD6Yc446LvyFybzdqut
	4=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr356853675e9.16.1795611196651;
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm736573735e9.13.2026.11.25.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Message-ID: <45510e886330ade6013838f94cd84c688b263aa8.camel@amutable.com>
Subject: Re: [PATCH v2 08/13] ipe: handle errors from resolving the real
 inode
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, Fan Wu	 <wufan@kernel.org>
Date: Wed, 25 Nov 2026 13:53:15 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> d_real() is about to be able to fail for D_REAL_DATA. So switch
> ipe_build_eval_ctx() from d_real_inode() to d_real_data_inode() and
> deal
> with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode and IPE evaluates the policy against that.
> The
> overlayfs inode has neither a block device nor any fs-verity state so
> none of the properties of the file hosting the data are visible.
>=20
> Instead, leave the block device and inode state of the evaluation
> context unset if the data can't be resolved so the file is evaluated
> without any dm-verity or fs-verity state. IOW, IPE reaches the same
> verdict as today but without looking at the overlayfs inode.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Suggested-by: Fan Wu <wufan@kernel.org>
> Link:
> https://lore.kernel.org/all/4e9a39ac-9ad5-49d8-b0c4-09e665504609@kernel.o=
rg
> Acked-by: Fan Wu <wufan@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0security/ipe/eval.c | 13 ++++++++++---
> =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 4a7be96c84f03..a2366eb9a47b3 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
> @@ -102,9 +102,16 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx
> *ctx,
> =C2=A0
> =C2=A0	if (file) {
> =C2=A0		build_ipe_sb_ctx(ctx, file);
> -		ino =3D d_real_inode(file->f_path.dentry);
> -		build_ipe_bdev_ctx(ctx, ino);
> -		build_ipe_inode_ctx(ctx, ino);
> +		/*
> +		 * If the real data inode cannot be resolved, leave
> the bdev
> +		 * and inode fields unset so the file is evaluated
> without
> +		 * dm-verity/fs-verity state.
> +		 */
> +		ino =3D d_real_data_inode(file->f_path.dentry);
> +		if (!IS_ERR(ino)) {
> +			build_ipe_bdev_ctx(ctx, ino);
> +			build_ipe_inode_ctx(ctx, ino);
> +		}
> =C2=A0	}
> =C2=A0}
> =C2=A0
