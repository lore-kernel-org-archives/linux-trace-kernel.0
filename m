Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94462D6401
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Mar 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772869954; cv=none; b=q7tDCYASTD2JysLuFT7SU/FaeKLmUcLDCHaMAjA0Y52YfV5nxxKTuPnsyRtiV4Gkp+38fxxODUGl6Nd0XtYXqx8X5pFt5Ek+aDQ6Y+SWR5E09yivinj7pleCXFb+fSYMbuezX7OnS5Zf/ip1HgkbfY7SPkV5cj9qEcxJEiRjzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772869954; c=relaxed/simple;
	bh=PLl3ybbEvtBt4usL1tVzzE3ceztfK3Ph05TigYRMy6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvKQWo31YuNk11Sb9jkGEeh4dYIIGjfhPR4Jq12RIuFgwb7a6660g9AktVcNM3whsrLEg9jYSs0YJpZteJww/LrtEtfMADm5QcPTRvoLU4dj+DQywxjtzxt6mdcV6s/mJHXFmc2wassfIDFkdd0WObO6UOgmT62N2oBUeK2pqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Mzgeg7MI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Mzgeg7MI"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439c6fc2910so2711993f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772869949; x=1773474749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82vwVSYqsxgUfO5PF4fV0qSf8sFXrhZ9cxXt5gjXgk=;
        b=Mzgeg7MIOIrjh+c3vI3Akf/UIjsNyGah6a6RbQ11xw0pXsGQ+c9Wsv43WQfpej1Mfo
         dtehQ3GsKzPO+PydcLr/RnoknSaS27Z/tH49od5FsnCCB7MeCkj8qyLutf1JLXc7Fdd7
         ThvyXVsnu+Q7c2an3F+1SjedMiGdA5C3dSfulg93qQwup8IWQ6elfpQlhRQOTAZH1tP6
         P+tdaZ+mC23yQicU1Zdxxf+JCJiq4BYqQ74/jU3PUECHrc1dPph9IWH5Nv+NXSVTl1AT
         cDQz1MeaW1cB5T9aGQK5Xs7tR9qRJPLK5Fki8r80GzKu0VJmH1PfO3WLJzy6zXgIMh7V
         I2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772869949; x=1773474749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q82vwVSYqsxgUfO5PF4fV0qSf8sFXrhZ9cxXt5gjXgk=;
        b=YXW7F0HTFS3lyWielUQaS8I9HOuwaAlwoPYj0Ltd/Cj8nitZTbDobC/7R9BWHJglUU
         Z7zbjDrDWAYOqhRr3+//ZJYYj5FInWTE5a1nI8OcPFmFwtPiCqTRkQtAlrq/UzRVIJwn
         MUBVleE1JUuFjhibLnKrygIQS+a440Bcf8hniI5cXwxPFCuI6+J1eLkg8U7ymVtvfYkd
         oJGddKv22jn8g03kNOC15lXF0JVCeNS88HnTMcRli2pmwtDgJc2S1GThUJTZwghP45ir
         FhiqfmF0wQOW5BfDXdUm8+AQzTeLFrYxNf6T55o9cpF0q58AvM3Jysv2JIq8uJ+cB2OY
         7ZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVtJg19Gdw8KQw2h1aQ8t3eIKjoMMU7u62F0NMY1uGSx9ALNCGuYP8EG/ouMxYCc53FA4PmGbqrm0zx9Gx89/R5Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89rGY973hnoeJxkQO4CoTdp9gxD59BrM6yN5IBJD6LnsRUnEP
	sSOdc7l1hzbOkvvFIjPuFciem7f8tRMUY27XYnjvfex5fkSMp22TPxTGtjoPWjDilAw=
X-Gm-Gg: ATEYQzyWplh5HALEcEmllJVZjJ0ycKLLnRWDxGJ1ZGrQwVVHnl8rvtFmxRTg0zjRMLa
	jhguR6NdVzt27CgHdXrTE8evVh7meCi5+gkNzJtK5O2ytkmKzY7+eJhDP2vLwJu4L7tS6Dug4eZ
	x+dnVZ0gXmsHuO/Blo5V5fi551HYbI1OhzjRC+VQVJRaG8J6EHVH7RAGayzPDLt5pLagejstVoP
	JyzNub5z+nmUSlQFQIpSLdMrTewzMT/GpOlOhS6An8GsxQpeElag4Ef38mr0yPZ4KdrxZMOX+A+
	7uxzjkW6QzXhLaLgCPIPFMUgUXmSF/yEu1/OUwxYtiYTYGANNfNHVjz/eSnB0QAmEDBDU9pdNto
	2u+LtNnMrXKVWFiZQ/qXEhTCAuwssKNCkhSc7TlMHCRln9NP8yxUdqnGZlJshQ94W7TVa07r6xE
	MjsCivWADvohSUjkHrOIGDJlKYWKheI3w=
X-Received: by 2002:a05:600c:870e:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48526951415mr82861225e9.19.1772869949098;
        Fri, 06 Mar 2026 23:52:29 -0800 (PST)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852381c61csm36839135e9.11.2026.03.06.23.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 23:52:28 -0800 (PST)
Date: Sat, 7 Mar 2026 08:52:24 +0100
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
Subject: Re: [PATCH net-next v3 01/13] devlink: expose devlink instance index
 over netlink
Message-ID: <xf2qlcvpmw64zpqsjogibda2ys33vwyectptwo5imdstwtp6a6@qokwax4d2iwn>
References: <20260304160022.6114-1-jiri@resnulli.us>
 <20260304160022.6114-2-jiri@resnulli.us>
 <20260306193253.6d7d2383@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306193253.6d7d2383@kernel.org>

Sat, Mar 07, 2026 at 04:32:53AM +0100, kuba@kernel.org wrote:
>On Wed,  4 Mar 2026 17:00:10 +0100 Jiri Pirko wrote:
>> +      -
>> +        name: index
>> +        type: uint
>> +        doc: Unique devlink instance index.
>
>AI complains on patch 6 that the index is truncated because it's saved
>to a u32. Let's add:
>
>        checks:
>           max: u32-max
>
>here and the policy will take care of the check, you can then remove
>the explicit checks too

Okay. Thanks!

>-- 
>pw-bot: cr
