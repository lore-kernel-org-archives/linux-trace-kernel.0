Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21953B3888
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320254; cv=none; b=mi2Thg0GGRRccmGE/tBfuyFldM0RPCqA6Cm0W8mh65C7g49MuR8UrsiS3MuQNVHkNvoSbBactnR8dABKRhVeZi8KA5KJrV01y6RyxHVJaUwL2ddWHgeDKeIaU0lFQEcv30k7GWo89Z/Y88IDqCtDfOl2hTfZIOioPXMlfiDaU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320254; c=relaxed/simple;
	bh=Rr1jkAP22lZkLvo3o90a9fRSWh9+kilNKtAarSScWFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Saaewb2zUVyOAdtoims9JacBBeRTsQIqB96AjRPrL7XPLx6FQIlKmrGX+REFRf8P0c33G733IHprj4h+iwb4iE1WJABRkljSf5ln9vv6PKj+RwT22iUkU9IJZvyFbxTGyeBwexx+1uyECicAi8qHQX5tvxUQL1lLrGdRGIwcatM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fHqxjqGD; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fHqxjqGD"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5094b54a250so5475731cf.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773320252; x=1773925052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=fHqxjqGD7mReR8MT2yBowt9MuNKPAKQc++mWcb4ZOttX6YldICO+OnnxWIQjO0C8L5
         wjOw0Gg7MqV4U+G9pES+s6h1NtZIjaKrBXMW81hrLyc8SxWYHtvQK3FlTjqiyroZskXE
         jYj0kUENL7Yhu5zg+0UQ91XYlYYlozX9U8uAqBEFaih0fSnDo8kprjTDRYJ58gzKRExo
         MSUW+Q+e0P2WpZGotx0DuVRaUqq4vGsUUSX1YbPnOxmRUKlXFY/aNRmXMXDbAEfx0Lnn
         e41FpuPSZjTSuTkWfTMW8e1MvewVXC2p6zLd4GrSZjvSKS4Q06nDQYaSimUW3qR5RhoY
         JV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320252; x=1773925052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=u2UCT5Zc2R9aE92R6AZtKL7v2zwfKO5LBuGohaxFKEsd3Eb/6NHQMSbVRQgdNYf38S
         /ojKhbIpD/uC4cf2oMcLil5SZez1Rl6v23tEqc6Its0g2/sTb/IsrEeCu4JeF7h/sFm4
         rHuu7puZtB6nepyW3gNPImM9eIjBcxQY1n1JWq9jGlYV1czDwZyJOD4TKFZXhRuCm9A3
         aKc8WMQ6043T7qydD3D7+spN0ym0+D1kE6uDMiz5BGuUYEBZe9zFAJPXBLIqy8BpfYa0
         m37dYQ2Bxc7gz0sawdKME7Z9d1f3w+UK26BrXZFQF1DUIxwOUn/AswzfXzZh1Tmr9kCk
         n9eg==
X-Forwarded-Encrypted: i=1; AJvYcCUvn8UfnkX6HuF/G7ncZqmRYgExjhV1rLp7lsZSs2OZ0s3Ah0RM5aQhePd/PPgLjFMCQr2oNbdf7cVjT7e0YZ68KeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxRHDD1JvtgRuIdS9LG+T8aDhqcJoTov93cmaskK2bTZV6ac9
	etH3nKYFQvUNBXNr3kr0lYl7CEQuwr1M50TTP2YnltwVSQO0lM28qw82bJ8uiG+kHR8=
X-Gm-Gg: ATEYQzw6eS/zf/CtdzAc6Cme1zv4XGQdfJ7NdUJ7I7mqahuP4O5IXhvWEsA9CzQJ6fX
	29+SWNUQU2Y7Xkjq5Z1yMVpqgBM1XmuGk/g5FY5h7GNUXFR9AJ4N77Q8JLAfmoH2KuLaASSyVcV
	qs1dtmivDR6J29OJki1981op9hgIndHiPlUpLIJicfTZatoVDdNlAyAr7qRIyzpsFbmcvS0XcTB
	Ir8qI2NxRE7YHuNTp6aFhe7aOaA8Pa+hbh30lsLV6sSxOSEQ8lxjHA7EIjB3m12HIZlokcI9dxj
	z9U5uLPmbxCYNH3lphYeBhVqeG8hEGOoJaE5IsGzK+iLXfwHjmUNDcuZX/TpjYtBMXFDBeCeMYL
	BTxc1fqzSBKlbyzeImkp5FHN9CYG/xvKkStyLZ8C4nWt8l4OhtzN6qZnyga2iOzRG3llcVeJLxa
	xY3EyiUYsiYyg8nfGa9XxmRYbqXJW+GeRkhLEs9fgvKJevgBYBHVLBcmNyAeSVbJgPGg//TLTJO
	SPoQG8O
X-Received: by 2002:ac8:5d4d:0:b0:509:cbc:127b with SMTP id d75a77b69052e-5093a1bd58fmr77950521cf.60.1773320251710;
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm33341196d6.8.2026.03.12.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fbW-00000006fKD-1POa;
	Thu, 12 Mar 2026 09:57:30 -0300
Date: Thu, 12 Mar 2026 09:57:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260312125730.GI1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBlpGKO842B3yl9@google.com>

On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:

> IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
> flawed API design. It usually implies that the caller is unsure whether
> a failure results in an error pointer or a NULL pointer. 

+1

IS_ERR_OR_NULL() should always be looked on with suspicion. Very
little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
implies ERR and NULL are semanticly the same, so fix the things to
always use ERR.

If you want to improve things work to get rid of the NULL checks this
script identifies. Remove ERR or NULL because only one can ever
happen, or fix the source to consistently return ERR.

Jason
