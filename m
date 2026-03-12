Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E334C981
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323751; cv=none; b=NA0+jHXN4tOVvD53DGrv8AMqK2yWv2sVaZcpQmnIpLksW0JrY6kck8xGS/br+nAGs6Xew0kw1qvpJGGJQO1fgOwKWtpr7QAiCS1cZCtXREl/g5L99zGHpDdy2saF4rP5L5A3H1/A44oGFIY3c3n6YFEK1AIlza85dhB3jdPUty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323751; c=relaxed/simple;
	bh=dmWr5E91FshndRY5RZ2Md55bF+x5yW+C43tABssFijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FLO5dsx+Dp3r/840d0MPsd8fyGeRoh8A+lOAAryOTHcNpjM4HBzZ7iGNiSQ0RiueFFjtMXyPeS4136aeBbgXv9U0iBEultZZTFYvM2t6XdHFTDytlH9dTO2Ck+BVXaSlM49uYj9BBKkkTvu/UBi+Vka5yQ/hAAMLfa0vhqIIGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzRC+Qn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzRC+Qn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773323749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bEtHF9LXuLxS0ovXAZV4W8RauatzMwv6n2P0Ur61wyU=;
	b=hzRC+Qn9/AH4LUgIOPr32tZuwTEuB33AXwkFsFQr3c2gR2eNSQS4ROkDPTOZ/CSUFxoIFu
	OXYaY36Jv9LIidC0gzx/S+NEn/b0e/uBggEUV9nr0+FO07s1oA8ZMS8JZu+Bxsx57ODnIk
	yaQvotzx5FGxjz24WuVELD0e1P4ygh4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-4h0zzqr8PLGbG3NCF5ZkLw-1; Thu, 12 Mar 2026 09:55:42 -0400
X-MC-Unique: 4h0zzqr8PLGbG3NCF5ZkLw-1
X-Mimecast-MFC-AGG-ID: 4h0zzqr8PLGbG3NCF5ZkLw_1773323740
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-485355493aeso7141455e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 06:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323740; x=1773928540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEtHF9LXuLxS0ovXAZV4W8RauatzMwv6n2P0Ur61wyU=;
        b=YMLRmDMYzKvaeen/dMdZt0juYxmrNilriiiNMQQPsD8glT5Ht7lfancF9sYxJ1BE5M
         a+gKXqOAaQzyYw0/HSoYuLXox8ES2nY+TKo4IykiODpjZGOsipV6e20Vw5TfhqebpreY
         SlSl5jQYEDGGM00WnJ2txEFcvbLmXezfzZX1DlCc9N/MgDjPC2Z68rB1aqRUP9he7eth
         urK01MDk0amIgQxcA+ek3NHDm7e7JbNQComlB4Fnezcxp4JQDtToaBelprqNFNnJPMJs
         xCSIqow+h+8gQ4IvWE2LnIlDEF2gNH19SDc8SnHn9cMcWlYpDTtkkl0obrK9Sb9tQm0K
         ihaA==
X-Forwarded-Encrypted: i=1; AJvYcCV1OmUXSd+ZdDzLbmIIaUa7TS2TFlzssO1GAhNqaKLnhckl+1wKNApqjrHHPDrN/ov1Mig3VP/IIpybkEZHPDTuHWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7GuO98wldwOlgJTx5v6WVKhHIGh8mfx5uYAFXJeMgS54ZoZ/
	gdqqhuQQGfmA74leOirDYAnX72kyn5tVCTjhgz89OeWn6qw13tqh2i9keRHxJ3vQKaLf1h2fIQM
	7k8wyBzz7cLmz4LaC5PpjMhjDTp5uXg6Sxx/Kw/N1xzF3iAD6UHNSsflb0vI/HbJhFwf6PDPQtw
	==
X-Gm-Gg: ATEYQzyC/h3Dmt0M7rULUKrRDeQxazBsYviE0dGrnoC6qKOFfDaQ7TG1OFuMbQULEx+
	6per0hKaerYDlCeZGDqLI+eY2bmmRxfhwhs2mcbWV2fV0U5tVnQKWtwhWja5BXRBEgP69DZ4xLm
	a19wR+oK15PQ94tMyAn3/H6r9x7PR6aIkR4kiztu+91H6mAVNDXTDto66yxjF005ljx/DVuPHMU
	SWmAsOEAiHqXgdSK6hMNEQM0TeoljhqIAHBLKVq/dnyNj6WuN6Sy8RTKDxrXVYY/DWuIoqyjr2X
	9+SVx5I0N4LTCAqAPuIrrZv/U4jtH8EigaQzGrRimrVGRKnvMziGMoNbL0ttvvsCIlZPmX0zo0r
	4DmnoK6pnGPdzkRM5832NUc84NzrMbxArcfQ1VUnrUXwDq8Ux/5I=
X-Received: by 2002:a05:600c:630d:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-4854b10cdb3mr105385115e9.26.1773323740364;
        Thu, 12 Mar 2026 06:55:40 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-4854b10cdb3mr105384515e9.26.1773323739893;
        Thu, 12 Mar 2026 06:55:39 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.82.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f3cdsm259618805e9.14.2026.03.12.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:55:39 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:55:37 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v7 15/15] rv: Add dl_server specific monitors
Message-ID: <abLF2UPW9qb0m1sZ@jlelli-thinkpadt14gen4.remote.csb>
References: <20260310105627.332044-1-gmonaco@redhat.com>
 <20260310105627.332044-16-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260310105627.332044-16-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mdIuGJcmKBCIfBrPNHNdaZOia5R-lzmGsiTDL2l4K18_1773323740
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 10/03/26 11:56, Gabriele Monaco wrote:
> Add monitors to validate the behaviour of the deadline server.
> 
> The currently implemented monitors are:
> * boost
>     fair tasks run either independently or boosted
> * laxity
>     deferrable servers wait for zero-laxity and run
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

