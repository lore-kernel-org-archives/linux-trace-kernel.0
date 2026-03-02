Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85439B962
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447004; cv=none; b=cHE2OvMhyAvkvm6Rf1RX1/IRvjHGR5b4S/+mnZ1Ofp62VqauuV9ePsJ2dc2rkW1Fhj+mgJPr/eky5Biud9z/HQjl0OR9o+eFevQMaveL6WL2erU43MiOO079flpj0vvpEp2l0DqCF5RvH7Sn1mwsy7WQGMnehZZoN0MLhqbFQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447004; c=relaxed/simple;
	bh=DxIjiuRLSsy1tFjfqwnUtZGdPPrFPa2emHdfIPwLGaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKUq//8CLnOJLqR58SJB46LfXBNAzq9if6Lw/Fe5Ne6wHqiIMfzvxCe7OfZy5VQNPcNePq5tKgbZdp6cRlRzUqtgOw/W2jkfs3biJSjhc/14s3tT5Un8XADf74lsbyjpGuARjNi7TTmAS/Llj2TmDbdpTl2UIOReAc6xS1BYauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qejSHz/m; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qejSHz/m"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso998023f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 02:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772447000; x=1773051800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyf5aAwmciBE7QFfA+/PpQQaPUYccIgX3fQYsSxVl+U=;
        b=qejSHz/mv7HaqVvybUq9mMdRh91/klcPbrp8m9TDyN6bXhHdCoYkRcI+r0+jbsLuON
         7V780DKi5GhyAkBytjq2KpvODxTn0X03VlsAQQpYS6py12jJWPQrJU7/rm3LBHu7lD7i
         UjCVZcSmmNp9mKBlkHOADSXgpl8s9AyI1yxAK1XFCzUbfbotkL1mOYOqvkD2AjRVQ+RF
         53EouXoHMx31/vSAx9ke/y4E26GeiroFmRLRGzYCSy169dWOQmA9ViMFPosIwtLRY8kX
         1mfWQ4UXY5lnssavO4yvfLH+vmR2Zt/3QzPiKwI8xtJiuEaxHRgMNv+JLyrRZdMDBTru
         SN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447000; x=1773051800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyf5aAwmciBE7QFfA+/PpQQaPUYccIgX3fQYsSxVl+U=;
        b=s1UMMiryGJEDtSOi8mpQ3aHNdAeyOBZSuzAfFhFr6XxG7/RI6iMVsvTcuCmMnWYmSx
         QUB6mvdx760xKGX4caofAAHQXOhlNYC1tJmcusdq156DTimV010oONxA6cxjkkNZTpp/
         76ToSZ1R0LIbB4hLJVTGPYvx1gS0OJHU+nxv1KJEW11qf5y8sh7a9LcM0d7TgGzvz6Sx
         ReBad7j7S8XUKSYxYsAtkYNC2V+wmW5iyeRT/VcMMGSP4zAznQgcT5O6ZLkY9GIsvqjS
         x+LqxA8JBialxd5Vy8a3z7oxow1vjiGkTMHTZE2P2blxIsjxqGXd2GhfWhLgiJ4oBPPh
         4Rfg==
X-Forwarded-Encrypted: i=1; AJvYcCURbpM89mYQU0OSacnrz3Dd34M0KYrYN/jH+D1mcz3eR60+C1GokwewzTZiTyFf1tGoKEREjpZragnVDshUvlFtXcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo50EXAVuZWM6OHfQofr2PkTPaNmqJ8QO0F4cTgapj9JYSaoW+
	cgR8a1ziF/Q43eY4u14pjJn51lvmmX+ceGKr5GAnR1aBm1BdoO62RnMp4w5JzxdSa78=
X-Gm-Gg: ATEYQzwtVR9dbevpcC3iEl1eZLfEKzSM0fZrN9qdZ3WLSiSGinZT5yuJoMmXgMzvc/L
	obuJ30Ppn8WRe6xe5BwWn6YAvxn8drc+jUKViOwU/C5U0y3VSq1hVv18pzi/fp2H2933hl/py5K
	BFsp53BhLwqAnQA2xY5bZHjINO+UigKowuDq5WQpy23MoVps8hZbEJOJ1LnirtTCddiS38I5Soh
	fzmdjuCDGFQjyNqbGYSKlvVkbdrAvpFjuSQ7WkdtuIUCwEUNbH/SG7krrhzzG7nY65ARM/XyTM1
	XoPL6ze/ig+W5vNQIhS7pq/7ydqeDME1aZjKNQIOul22FB+fH3uBT4XiQP729N+LC68mhgsfJQu
	dZW/FSe4hgx7f11ZEwkkHLBCNb3iDvCljIETnfZ57iJahE17vaCvNzkBLboyGuzBs5YGSxQ2Ah0
	0rMurXxg9/82bncHiy68FzFf4PEHGoRNA=
X-Received: by 2002:a05:6000:186e:b0:439:b374:c6d3 with SMTP id ffacd0b85a97d-439b374c7b0mr7633629f8f.32.1772447000348;
        Mon, 02 Mar 2026 02:23:20 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm12378754f8f.16.2026.03.02.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:23:19 -0800 (PST)
Date: Mon, 2 Mar 2026 11:23:16 +0100
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
Subject: Re: [PATCH net-next v2 04/10] devlink: allow to use devlink index as
 a command handle
Message-ID: <onwmw7ql5g2xqacrqnawcphdlzfu5v5ohgslsbvoeraszm7m4m@2ywv2ql37wu7>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-5-jiri@resnulli.us>
 <20260228144846.40f5dfeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228144846.40f5dfeb@kernel.org>

Sat, Feb 28, 2026 at 11:48:46PM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:16 +0100 Jiri Pirko wrote:
>> +	if (attrs[DEVLINK_ATTR_INDEX]) {
>> +		index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);
>> +		devlink = devlinks_xa_lookup_get(net, index);
>> +		if (!devlink)
>> +			return ERR_PTR(-ENODEV);
>> +		goto found;
>> +	}
>> +
>>  	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
>>  		return ERR_PTR(-EINVAL);
>
>If both INDEX and BUS_NAME + DEV_NAME are provided we should check
>that they point to the same device? Or reject user space passing both?

I implemented reject. I don't see much of value of allowing both. The
code that would do the checking is too much for this hypothetical case.
