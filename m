Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED894D9558
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850462; cv=none; b=nLbVnLlx/dIpGO6PSOQ7FyGmERD/Ilop/Pxh6kXlPr6VvGq3WpjNcn+F2QhmNE+MN+JzgIyrKbfnsTYYMJhFs0Uv9MofIh0zV84qBA60u0if7kMUEd9x+ieo+upjArsJYcgmaq3yfBx4A3ifehlteo2SygqQClMl43rqsDl17YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850462; c=relaxed/simple;
	bh=2y4gEjNzgA3MrPbQRg5Ifw5WWUUepc12pSJtVJWCuNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD1Unm8GrnXwkJ6iHV0W6dE8lkKZ+LGP8WvUZR5xNHD+Vsawd9wJBQ9igqDfW+QHt1gksfahAFJJGCSCMKGsC3wOXBlGXZXvgn+1ibEa7XywN55yEhzwjF4pOf8S3d/fcqjMrx+9MBxPe/McixdB25diA5mW1X4uP8T2l9ZSQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Js8hr/gx; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Js8hr/gx"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881a3a28e72so2395985b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790850460; x=1791455260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zOoZbBrkeSpdFA8vWrJINhow0mO467LA30uvn4Xle+I=;
        b=Js8hr/gxkm08MeaRvuDgNr+iPda5i6qBPBSUP4g0y9i+FDF8Z4TalxCSF+ZgmaLVo0
         mCOqmMVQS4iQ5wfblzULoMqXCcV6ZJzCQ+w3+v1UOngMbAcD/qhk9emqRnzCBxPKAff7
         qJpaxxjyfXiO9jUjTRt1VRr2vv1ar9O8NF4ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790850460; x=1791455260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOoZbBrkeSpdFA8vWrJINhow0mO467LA30uvn4Xle+I=;
        b=Uo0/WMmxMfScmhjG8hpzZpuu6hq209EmWKNM8OYOH+3GgbOo1gLOjJdzWzu9RpYxrg
         S77ofRgyryBR+Iccj0vtAt8Co3ZaP4l2QLlqYRXtJ6C6QVltxdgOjQ9ivNaLA8fGWWKD
         F4BWg1U6QPhD2L0Ic0fhcQh0mmlPjynV+pL5C9z05vL4huggvMMFtHk97xgvMjU0w3sr
         8ujNemwPGfkFt+qztty4vrRWhvHfMYo6opBvLBpcsbdKx/Qs+Y4lKdoPvhpOoGWHlQLA
         Pb1OX8hGRXDETtexiqZs4iQqX3b4FPGDWZUlfYzRmGuuCzSFfCj8HkcSguhxy3/AkOKm
         XtSQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6vHYYtCv6/TPptiUQ8Fe+L/cPtLJsyHUG63KLauZPzQo92Ii5RVLt90zuoEF8cgl104s5k82CV9MRNIbhw5f/IPk=@vger.kernel.org
X-Gm-Message-State: AFuF++lf8qBxd6fP8IiidleCtvXH4B9zI/XmLJjgBqYaXE0SOcfuRap2
	QoR3G5PHmvFOtjP6BGr9nn7IxZquDI5YK467Jqva89d2BvR74b2F/2hBPClrc+m4eQ==
X-Gm-Gg: AYBFou2yUhEwa76cI9Q5719eh99Hlu+U1Z44t/pDX4Brp3vmAO9YB+j805oBtGeIuYX
	MZODq1djh4cXiQFIBgunX6c1hGuiwhoLZkvkt05Uo0mqY0bzFp8LFy4WExyw+esiFJ/E8RjbGZh
	lmASF1bi2naXZJNzUMdNSFKrPH/qYohgHZMv9Xj4NWI0Ui4l1R4wqUVvPBIxEmDJgqK5qnXXJGE
	ZMD9/2DxnYUrcj18qiZeZIB+gfhjsHZYwXbGPlVJkoYKYLC0XAqWKRrn34zJXWjJbxhQrgIdJql
	/voE7S+f0+7RabEK4veP0pv22f87fMTpqyh+wPOpyaTadkKiuKlq3Txize7dwLtwe3Mppo9m18I
	ASSPgTvAdX9KNaqt4bG4eLPTVZ364pxTUOsbzDNx0ICxfFCg4MJciiPAXQO28hyOOzIhid9Q90+
	JTE24fx6lXwtvW/4TJbA68hVAZfszDf8AMESjHYwnoOz2u+LEOERl3H7e/kgV1226ITYhzEpb4X
	RQCThg1+/naqbf6mMMkXEJkoun+uQ5W5FVnVOo=
X-Received: by 2002:a05:6a00:b81:b0:874:705d:f64a with SMTP id d2e1a72fcca58-8874bffd4e6mr3058007b3a.44.1790850460353;
        Thu, 01 Oct 2026 03:27:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:d042:b5fa:ebeb:ace6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88818719cc8sm861475b3a.16.2026.10.01.03.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:27:39 -0700 (PDT)
Date: Thu, 1 Oct 2026 19:27:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <georgi.djakov@oss.qualcomm.com>, andersson@kernel.org, 
	konradybcio@kernel.org, abelvesa@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Message-ID: <ar4070oH8lRCJMRw@google.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <20261001-dramatic-hasty-pug-68ebfd@quoll>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-dramatic-hasty-pug-68ebfd@quoll>

On (26/10/01 10:51), Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2026 at 07:52:13AM -0700, Georgi Djakov wrote:
> > Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
> > zram can expose qpace-lz4 as a selectable compression algorithm when the
> > QPaCE driver is available.
> > 
> > Compress and decompress operations are handled via the QPaCE urgent
> > synchronous path: each request DMA-maps the source and destination
> > buffers, issues a blocking hardware command, and returns the result size.
> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
> > ---
> >  drivers/block/zram/Kconfig         |  11 +++
> >  drivers/block/zram/Makefile        |   1 +
> >  drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++
> 
> So entire qpace should go here, no? Why did you create this entire layer
> of indirection, singleton management under drivers/soc?

qpace seems to be standalone/independent arch/soc specific, and can gain
users outside of zram (fs compression, zswap, etc.).  zram's backends
potentially can disappear all together, if we switch to acomp crypto API.
