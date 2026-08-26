Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737D301709;
	Wed, 26 Aug 2026 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780917; cv=none; b=D+ZT/DfZoc2mEfmeEV5Mockh9M+2d5z63wFjAJ+EUN5iwe7W6hYiuHbSqkt4+9b7N1D9Ota44weXgF0plVVYmi3euVX8BzKegdk+OItdjXULveL2RwzFBSgK0TVcjP6r1I8EJmbY4omf/RmFKX//uPt/093IJj0O7eYOKoH6dfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780917; c=relaxed/simple;
	bh=S+M11efHGjlFOGyHsDkQEbKFOs2KGG1O1JcPU2U8ock=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g7GVOdsjUmuD12qxnxPnl5323AXbuDwStSltheVffAIicMUjpI8W0niNUzF5IiL8sDQUMce5cJToFPeABHgr2Bax7LTp3NTIfplneZxgYATD6EpdYRALMjDrU21Ucum3/nxcMOw/GclYk6faaiCdHUwsghWV7UMBYqDxsqaPYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=W7cdHFwX; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="W7cdHFwX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iXLY2MtS3chA1nqXEFiMJGuRPn1QEv7gPIPmXwsjt6c=; b=W7cdHFwXvG/Worl/kdLsbl4lot
	c0vVVH4EiQm3qwO9Q5/peDEECq+t/V+gbzTBNFayBX44L8SMtQ1G7djErOk2osiP02ZlVFNQBEL5y
	uLb8XyrNZsi15TpvPNFWi9zMo/5QgTtXHH14BpnIKqAMX5jNc4uO+1AOujO0lowf1WVdwo1bGAZ/Y
	FBuKCZs5blziAGXBhGQxIXa6TVQ/kLcIkOHFXdx5cwmr9LnX8SWghMyQiQ8eMPiBfKc/GnGSAapAw
	zdJdINEcLBnHgcvjlHUEMcEriL/ty2mMv/alJ5qetx8etDPvDiCRWYZpFsDFK28eTlfcwEwq+RtRT
	tzvUyflA==;
Received: from [::1] (port=34484 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1wzLU2-00000009y2J-2hlg;
	Wed, 26 Aug 2026 23:48:34 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 23:48:34 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, include@grrlz.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Clear copied tracing state before
 fork duplication
In-Reply-To: <20260826152312.62d5802e@gandalf.local.home>
References: <20260824211036.3729669-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260826152312.62d5802e@gandalf.local.home>
User-Agent: Roundcube Webmail/1.6.18
Message-ID: <36329aac30d057120f95933c5ef7dec1@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-08-26 21:23, Steven Rostedt wrote:
>> diff --git a/include/linux/user_events.h b/include/linux/user_events.h
>> index 57d1ff0..2c9ac7b 100644
>> --- a/include/linux/user_events.h
>> +++ b/include/linux/user_events.h
>> @@ -48,6 +48,7 @@ static inline void user_events_fork(struct 
>> task_struct *t,
>>  		return;
>>  	}
>> 
>> +	t->user_event_mm = NULL;
> 
> Honestly, that line should be in user_event_mm_dup() and not here.

Thanks for the feedback. I have just sent a v2 implementing this.

Regards,
Jérémy
