Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201157;
	b=NHbXw86ePMLJ14GQekL7exepEc4D287Ds3REFsP/qRyTE1Ck6Aamklg+T3/X5FE/FxZg
	 JQBEUjKNmKEuxMrgVgldGba9UpT0CFUXv5VT+CS1nDByxi9/WKG/FY7IU3gWvqGOzz597
	 0SH4iAW1AgDH06405EC8vxsFH3wKAhC6sWVsaKEXDsQR2sPpyzknmWPebqOGfHT3tpTyi
	 5AMSZA/+aAYMd3FDxF2ZC8sLP0+o2D7t0JqVEILaFGApOlAFKDDAB1EZ7JQ9fpRxG5OpM
	 9eDQinHk23KcHcLCKxyAS0loC5yqkP4vE2h0ZqR7rHtNwx1h4uweCVWgjwTtFM1d86g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=tJwebgYCqnOwbw+tEDHyKOXYITgvxF1JqBIr3xmLP1k=;
	b=S5BskHmeYyRgz5F8DlJ4NUKv/3UqxNhLjC+/zzJWjCeHHgzpDIdxdBv8V7zqQrcWzp9R
	 LESJLs+OKNnOPiAWNXk13OsyNtdrskiZbo1tHZstzoFNEdW4tdp6AyoCV2jp//z8x/3AQ
	 a6OGB1tgj7fpk/7PN7DD2a8kiaa7QdkAFy9ANWTaqdAMl1KP3c3XlFhexis5Uc0e7mp/P
	 owPQ9azKVvDUvFYqr2swo/LZyvLmzHPW+jQhAVKYktCuHWUbvjrySWqVGpHLhsek+NpF9
	 qwksVAdf+exTIRCRtoDc98XvLNDDJ6KbKCcAdfXiP5dV74FQOQQte+Ko8CcCuUdHJMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mU3aNJZB;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C660A262B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 18:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E51C660A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mU3aNJZB
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-92119da3d37so11655406d6.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795201151; x=1795805951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJwebgYCqnOwbw+tEDHyKOXYITgvxF1JqBIr3xmLP1k=;
        b=mU3aNJZBRL8xUqWS/+Z7eLapx4QbOcTgVhU+sRd6l8RC/BU4tGdhmpl3f7TK7HXUDN
         e6WbNtj/CG+SB2L8fMXHAhgkzYS+OWZViqSQaN96DeEnuHCbbF3QyV+ORx+ipnLawE7e
         cC9jAUXHBb4BgVZLeGi1R+A9LGcu7JQxCnw6Qid5UMZ/ru2ubKJpU9c3WeRiRVPuISx7
         iQlM29eE6uHpDIp582x0bH1E3v/YLRIlUz8MQQx6kuMQ7rbGY5dfZ5OZrEc0W1eLmd0r
         W2tqTk89VFPb7601U+F+RmlG/JVcritFbVV2fJXNJ2hXrK+nfps0hqEj1izLBKF5UoPP
         lm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201151; x=1795805951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tJwebgYCqnOwbw+tEDHyKOXYITgvxF1JqBIr3xmLP1k=;
        b=sDMkU1knIBUXDuECZIptLoF70XaYX8y7xvSdmIlqumoGMzKTlWYC8Nxif1jlMGT4Vy
         OESA05PcPjnIWI67X1GVg/7gyQloPFWncNI9IM/KMVESU2Rom6x3NroYZfHA7mZdziRn
         JTFV5eXC8LgqWImxFEkK6pI2IF9wftablPONsGwL6vbRtLURGTH6v1E9CpZromcvR7D2
         Tir5W8ZqiV/D9iASpez7ed43xXJxbEqikGSemQMECmqlo8xfgVG1FoycyqYd5+a7dkTY
         8RMUsJCYcCWV81C0+/6aLW49p14Ka5CHJpECxTQvv6WhHuvaQh21mu6wFf3sm1heHl67
         JmvA==
X-Forwarded-Encrypted: i=1; AL+hErFmlQMmN/OIQy7SSo/Fa76ihSbRISF4JytrUvBlc2/LkYKI9l2/ggl3rFxBGVl7x8CSPO0LeT4y3StmLnFMMz/WU+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rAr6THSWvqP2YOOuUeNs8XB+s+KEWwJY0T5mtWKVYWlmeIS4c
	T32xmi9+bb1bwfu6xQDXNs9A5GMCpGM74lxBErrCNCsvbn8L2t92AJMu1wZtmgYT9hw=
X-Gm-Gg: AZFdTZeLdKi53TvIJS18KAyJg+zNl6atmi64/4d2KJkUOTWuenCH+PXAZnUJUdmfD2p
	AMbPdaNoGtb1ySGcW+MaXjp8L5DXZg7ssNKFEG5F5vJxySdeD16+VyieXXNAWSSWerE16Nl8RtW
	ayaVW93cRmuZo9SR/8bAU4B1D7kJdTxIQ7ozpU9nBD/NKuBxDidk2Wbq7Em7oQRjWSryxaP5nfO
	BLRkeqIo+HlMSq9RJ6+CvybW2rwiqnrYKu0jmMyGA2jbE0IaU9x/Ch+zCp32YU/BvIlbmT0kgUo
	KK/EXuykQvWBo2vOsnUhzvUeSVlYpxcrozrQFYW8QzvhFnierjztOdld0Aq+NOefQcDJnSTIDst
	mFkSHUXd2X1PRlp1hDfFX2E79OdUILiJrARNqPp0il4r304QcPhHHSL6voypbxMU7J48Tl3D/dJ
	bAB6fzux37zVcaVpbfIH27LIOqShB4iPPi5ovvhrUZGdmfATMtzJOJffivXvuqEyChl/7ivO7tk
	FI4iehRebiggvn5ecgrpOtLU/xxQTyLk5X7HMKSbZuSxsTCkdZFN3VumpFcD5iCAu+Esn4XpoMC
	7Tj0mw==
X-Received: by 2002:a05:6214:528a:b0:91f:171b:e02b with SMTP id 6a1803df08f44-92134b3fff4mr65009886d6.35.1795201150678;
        Fri, 20 Nov 2026 10:59:10 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f8c34sm34171876d6.32.2026.11.20.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUTpF-00000004mVJ-1MNw;
	Fri, 20 Nov 2026 14:59:09 -0400
Date: Fri, 20 Nov 2026 14:59:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bradley Morgan <bradley.morgan@linux.dev>,
	Armin Wolf <W_Armin@gmx.de>, Masami Hiramatsu <mhiramat@kernel.org>,
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] driver core: Disable driver overriding by
 default
Message-ID: <20261120185909.GB1133597@ziepe.ca>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <f7b5c6319203d288a166e6f811c6ea07e12d5f4f.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7b5c6319203d288a166e6f811c6ea07e12d5f4f.1795171088.git.u.kleine-koenig@baylibre.com>

On Fri, Nov 20, 2026 at 12:11:02PM +0100, Uwe Kleine-König wrote:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 8228c9acc530..ed505e362b1d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -424,6 +424,12 @@ Kernel parameters
>  			do not want to use tracing_snapshot_alloc() as it needs
>  			to be done where GFP_KERNEL allocations are allowed.
>  
> +	allow_driver_override
> +			Allow matching drivers without
> +			.support_driver_override = true to devices using
> +			driver_override. This is a dangerous operation in
> +			general allowing root to oops the kernel.
> +

I feel like this is more appropriate as a lockdown level than a kernel
command line?

Jason
