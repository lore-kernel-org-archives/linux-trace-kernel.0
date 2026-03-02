Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBA2E612E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444660; cv=none; b=dQAVLmrD760bWk2H6DmLVbDikk4rbJ4lI1inGZoFGvRjA8Z7JGzOY+N+6Cf3ioiZGamAeZSQDpAq1RSBjnafyUUAUTwvddnQ56ZPGiJ657rn4PoBpoNBtiTe1QdPZRcS7+KK2f75B85wjX1pslT342ehNy9FOuI+8crU/X2LijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444660; c=relaxed/simple;
	bh=EdtrS3uxbW5G3jVfOkaPkh4ppghbeIrW97LweZBsfrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZX0hOg0NrzfxrwH8JjFQw49B2YJ9PkCikHcp5uOecztYfG+ro1Et2H2l4tsm2U4dMot0CvTeG+vlvZ0S1jvSzOk/cxV3HDuMkpk1cNM+oJ6l/I368NWCPuwDuzHE8+iC7ydIzuqQ+2eseHUeNkgL5oolVnylPOqvSp1XL38SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g26/D8Jr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g26/D8Jr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so47544195e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 01:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772444657; x=1773049457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tdsnQzzh+Lt1pkN+nCw9kSvCEoqVVH6yGcbrKgciEAs=;
        b=g26/D8JrTLqBOq3QvS83H/OXOOvyQ0pD8LUrvootV47cg41Do/SzN3FliMG8nhE4xV
         FlO+RaB/bE07zF9Q/idTt5hcuGHO6xUtiNiQ6mX1vYFKRUXvVLUPnh8BSBkVXVhCZeWY
         I5xYJsTXr8nO62C/nXP6qcONQzThRAZi4+Dp9+8iWDdFEZUSBugdX41qKKqIGFRjEnRo
         HQ3PZRrmtqZdr1x0zSeeQYF0V/stEwfSAv347dxuv8EklNJAB2XnnhtU0SxRMPxtzIpC
         YQwl7nOFmFlAflxkFH97EcparEMqew3GnnN2MvFUKwu09rmZJ5GWCI8e1HtloyXa4Frh
         oEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772444657; x=1773049457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdsnQzzh+Lt1pkN+nCw9kSvCEoqVVH6yGcbrKgciEAs=;
        b=ujz5yqT8h7VRLOkF6BLX2Z9uGsq0wWFM+117UnGs0mttj3Be8iV3nIza/zcdrR4M89
         GUcpllWh2S3d90CJNstAMWkosBTimu3me3mmQ1cb6jyCUSTPsvmmulWSutZALIXQsSnc
         jZAM6QP7h6VEXJxQ7q5e3jhL3z0RvLxPrf0PMIupBY4E+eaO6zMjgAIM/FUm4lPc12a1
         RQB7UYkEpe85JXsJWh52m8F521U1Z5IUC+v0um0dkRcEjsINzNe+Fx9tWsqoSSCxDjnX
         Zll2SrdlsQUXC7WdWk9g+ngioYUQ31BCmluekxYVH1uj41Jvci4Wgibmlnw5Okf3NvZQ
         cRRg==
X-Forwarded-Encrypted: i=1; AJvYcCX8VSL8MoBQpBJj59+fCPU7ZgpzkHwViOwKxuM6nfXwiV6A4Gb415alFnV0zR51uVZSfO9BiUBIuSNp0MiQVBvQWI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgotn/zGrWMmT6mgs/JWEHkHUHG9oo1pkycl+YcH8dvSOI6TpW
	DnAOX5rhpAjo89sFXuXo9A24eTrIN03qQukussfl3P7RMoDB94r+52LTWfUITU+6n5s=
X-Gm-Gg: ATEYQzwxbbU7JCUZoO5jcYfgWz6h689wGyv+ppTxcE7G+uXoaQPKNTY2wEKX/wVxDsV
	ajIv7G6Nz5lSF3eTmHYKMyFh4Ecz1MF9r52fEBSoGHP3UAY9KP8bbh7T4+2VOJjqIHkicUe4UU8
	x4J/P2IDTm49hiVgZN14BfzlmvEYmvuyIITnyqunV+lkGxFZthQYbC7zpdBgDmfmyar3ZOOCBsB
	cF1HEljslBeJmhgE+8xPYKXBThoeOxKizlF2P0UpxROBjuwbZnFWx20r2KMjlmjM5vF5N25JJE3
	0Dm0h9sQgHUaCUEt5z7SctCmC2XBQ8BZRTEiMcZesA3mB174IDgwxqxK7ktBQ280PD7wzRXtkc6
	X3n0Jq5vH23YvOqQuQep2aJbbN+q/vPqXEhOZlQ025kjNRWxyGdCfzxZIg5OuB/9iF5nhhRxxqs
	B+p1V47PruCQG1Sdm4HGz54T8+L9yv0LA=
X-Received: by 2002:a05:600c:198a:b0:482:ef72:5781 with SMTP id 5b1f17b1804b1-483c9bfa529mr178963245e9.25.1772444657057;
        Mon, 02 Mar 2026 01:44:17 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb85c58sm127994325e9.9.2026.03.02.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:44:16 -0800 (PST)
Date: Mon, 2 Mar 2026 10:44:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/10] devlink: add devlink_dev_driver_name()
 helper and use it in trace events
Message-ID: <u46fbskiokav5y3mgleamlqoohpiyygnhgjyhxyouctwkfp6ig@tn53kspbmgbz>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-7-jiri@resnulli.us>
 <20260228145805.758ff8c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228145805.758ff8c0@kernel.org>

Sat, Feb 28, 2026 at 11:58:05PM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:18 +0100 Jiri Pirko wrote:
>> +const char *devlink_dev_driver_name(const struct devlink *devlink)
>> +{
>> +	struct device *dev = devlink->dev;
>> +
>> +	return dev ? dev->driver->name : NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
>
>You say we need this in prep for shared instances, which is fair, but
>shared instances should presumably share across the same driver, most
>of the time? So perhaps we should do a similar thing here as you did to
>the bus/dev name? Maybe when shared instance is allocated:
>
>	devlink->driver_name = kasprintf("%s+", dev->driver);
>
>And then:
>
>+const char *devlink_dev_driver_name(const struct devlink *devlink)
>+{
>+	struct device *dev = devlink->dev;
>+
>+	return dev ? dev->driver->name : devlink->driver_name;
>+}
>+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
>
>?
>

Good idea. Will add is in some form.
