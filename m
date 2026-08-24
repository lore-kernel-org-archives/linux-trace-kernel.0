Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BAA367F2F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585600; cv=none; b=uP665RlkYl73XlaKqNGDXH979zuNAjrSF8fWqbPnB5waB9FkGMO0E0lwZmFBSsDmJpHTe7SM/MgYodG9mgqDF/nXntbJ5xO8SuIrCpwTIaV5Xs1yjAvisHiFLLqpeX/r8tPmDTdiWiWRU3NsR7x5QXmn1+LUpP4IyOIN5MsbCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585600; c=relaxed/simple;
	bh=ohjRofdJUcuO4meBoHs4IxeqoaDQ04T5xwdpgwaXgbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hit22ag0PtOBm+ViJTijb1RKWXN0waQGl9otIc3N8JknBRjvy0hu1nOrGxqSxz8gfS6e+7rOfXPHIrs3b+7q6z0mFmBR7mJlj8ZbApBIbmUJROZAUe8pRtVcD+38TE3nw23Ct0/6ePMj5B3dcRyeVudZ+7VOjbZSM1QqQs65FWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENwteRC9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENwteRC9"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca80d708489so2086a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585598; x=1788190398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RAedVK5h+CJivT4Yy7dGsRjex7VLZDzbGqNcf02p9qI=;
        b=ENwteRC9z/m/QTcriDEGChiVIYa8k49pVAs0mICAF4OkxcH5C3oWraUb12jxeImMiZ
         ardCDN7xeT5s0dn/bV5QVvqLtfSIYNkvvazRLpG3xFa95AYhK+DwFt0mMkfY720TT/q7
         s5E5fvLZX5a6VK1DSsbo9Yp44yLm3cfxVURMBA4mWS3hYZ7A+GXt5pME/WJgnkuuAELk
         D3BWFN98Fepe8B3YS5zIb4RtZtfj3jbHluxpzmyXEjP8HIyNWCeEedxekuqnKu78jFDC
         BS7MjAHWBwOh0VxO1JstCqT9qpn+m44lRzmVRaCWA/Few731gRQqposs2dljGxDGB9+u
         I4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585598; x=1788190398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAedVK5h+CJivT4Yy7dGsRjex7VLZDzbGqNcf02p9qI=;
        b=jbnNi9mBAesSJpFE/WTnX6ALD8MypM2lYyrAEN6msqQal6AX0JGiAlojX8gpUl64G5
         Y/dxs1FID0LRJeoCBYXMXa3tOl9hn7Ek/OhB3gjr172IO0M56U+J9qufDbADTuFB0Erq
         Fvltcl5e/CR9C1vDsB8yxXrKFZHGqtTnPYabMVo7coaud2HxIqq38yiHHVcINijxpFJa
         Kw5Ewpe0XHSH0RBHePyqo5BRFG5OGLeADmlcUCCPVkm5X8VfQ4DPGeeyjyH0C8IWb9Zc
         HhEVb5i/dylWQr7NNhh55eobyGnoeZiUgguTDf91JD1SjTWa6YSZkvRbhmTg1NzCjQ2N
         dW3g==
X-Forwarded-Encrypted: i=1; AHgh+Roo06jPHrW6cMaWYZFagJduyJk0Y/ajtctSP3rJwNBNsmzDCWNu6VT7CPNc2vYcAT7OOta2rzEhZ9CWmXXWLoKvXFo=@vger.kernel.org
X-Gm-Message-State: AFuF++mfjJocg3fViPUa263ICV3sFgIWwHfdGfvGueozcC4FqclHSNqh
	W6skr3BPzep3t1N/UMAa9ai0uz76Sa+9rfeIOgwEg4lAlj8ZuKiDO2RS
X-Gm-Gg: AR+sD10YzykTaN5WVOoAfkz5tugJ/oeksnODPFyXqaLMEtC2nbyjHusEJmDmQicEQmw
	+XZDVsMj22KvF2wBJyPnJHrJQJN0IXoPE1qCOkNtTUqtYOKqHhdfzFCNYvDHbCZuhp4HwGDT93f
	PEe2hLglNUCIvx0mQNd7jaIU9hXuDhTv7bBd6MoqWAbFMnf+V2MGpTfUtINLXbMgDCvG64kVlhZ
	OWp6bemiuTwTsi2ayY76nbwHdr0mPSFoFN0TBXiZsYj2ZWcRSKjBOY8nYZCj9IhjgIUoQZG0cot
	MTofEUimhhd8o2CX1LUJcArbzBNH1Lt/q+znVM1tc9EPFXUXh/dd6prIvRh9buuCR8eylUcncmA
	YntVURieBii5+FVLCpHYPb7jFL74krb8EeyuRoP6nZL8MEwr1Md7T5n37eqwJsdlqnXd0FUocYj
	C7QFrJ42wu77CduL6ZggD0B3TfD8+GFnbKHxzRjYkV67+Add5htofRQn3U7j/Y
X-Received: by 2002:a17:90b:4b42:b0:390:84db:888e with SMTP id 98e67ed59e1d1-39645b1c818mr2587a91.7.1787585597901;
        Mon, 24 Aug 2026 08:33:17 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4a15829sm10440341a91.14.2026.08.24.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:33:17 -0700 (PDT)
Date: Mon, 24 Aug 2026 23:33:13 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] verification/rvgen: Use .old instead of .bak for kunit
 backup files
Message-ID: <aoxkOQ_P4CYWaKiw@google.com>
References: <20260824081519.81103-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824081519.81103-2-gmonaco@redhat.com>

On Mon, Aug 24, 2026 at 10:15:19AM +0200, Gabriele Monaco wrote:
> The rvgen kunit command generates .bak backup files and these can be
> checked in for selftests (make check). Clean targets like make disclean
> remove such files, leaving the tree dirty.
> 
> Switch to .old to preserve a clean tree after make disclean.
> 
> Reported-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Closes: https://lore.kernel.org/lkml/aosuwKH5GOEo0xTN@google.com
> Fixes: 7b6246294eb0 ("verification/rvgen: Add selftests for rvgen kunit")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks for the quick fix!
The working tree now remains clean after running make distclean.

Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  tools/verification/rvgen/rvgen/kunit.py                         | 2 +-
>  .../{test_bak_kunit_kunit.c.bak => test_bak_kunit_kunit.c.old}  | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/verification/rvgen/tests/golden/test_bak_kunit/{test_bak_kunit_kunit.c.bak => test_bak_kunit_kunit.c.old} (100%)
> 
> diff --git a/tools/verification/rvgen/rvgen/kunit.py b/tools/verification/rvgen/rvgen/kunit.py
> index ed2082d7d3bc..85973f918c9b 100644
> --- a/tools/verification/rvgen/rvgen/kunit.py
> +++ b/tools/verification/rvgen/rvgen/kunit.py
> @@ -173,7 +173,7 @@ EXPORT_SYMBOL_IF_KUNIT({struct_name});
>              for path in (header_file_path, kunit_c_file_path):
>                  if path.exists():
>                      try:
> -                        path.rename(path.with_suffix(path.suffix + ".bak"))
> +                        path.rename(path.with_suffix(path.suffix + ".old"))
>                      except OSError as e:
>                          raise KUnitError(f"Error backing up file {path}: {e}") from e
>  
> diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.old
> similarity index 100%
> rename from tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak
> rename to tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.old
> 
> base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
> -- 
> 2.55.0
> 
