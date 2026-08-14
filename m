Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8B46C837;
	Fri, 14 Aug 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711565; cv=none; b=g1kGFyykH3PctN0Q0MMtMtzhva9Nh9xyxahgQc9wGjiXbctyIJqqeaFpwazaQGttJepgZbN4+bLqCV3B/+YORb17Kb/xxnO03hb3ZkYN/LHAoNZk0GORyT2W/sUwVUsg7lNj4SpS/vMmRTkSDuL1wcRuWs5uVfS+t8OLV8iRZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711565; c=relaxed/simple;
	bh=Q7oLb2IebEwY9FyvUwM+X4O2fmQ9LXjiAJusy5N0MSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIxq51hpC0nhE3qCH9fwQ0QkGV30j2SZL4mPrzOx7he4qabnzCFd8uEp5z4DtpT9aXD0TtADQC1z2SI58y0tXrwMdjwvmkN+yEk38LKXAb3C3K1LgkDdXVXtYTV1HudKF+UK4xki3J/xvPct+EB3iJnOa6t4oYH1ERZeClVIx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=iA50cqJc; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="iA50cqJc"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CBB8DA2BF8;
	Fri, 14 Aug 2026 12:45:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 037651A;
	Fri, 14 Aug 2026 12:45:53 +0000 (UTC)
Date: Fri, 14 Aug 2026 08:46:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/10] ring-buffer: Dynamically calculate
 max_data_size
Message-ID: <20260814084612.75a15682@gandalf.local.home>
In-Reply-To: <an7K08bEyc70erD2@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-8-vdonnefort@google.com>
	<20260813213407.6bc29cc9@gandalf.local.home>
	<an7K08bEyc70erD2@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: je7hjdwr9nnwmofxiciijdpxw8f75hom
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 037651A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18owydMsG6RFwZvnee2P6mf/oAgDx+JfPQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=tJ2vMnUwa+PcDY8v+jTeDaZl2Wknzt4dw0I5HExDCu8=; b=iA50cqJcKUPBlXloLNfvEpjIkrBy6TM6l0SG+PW8/kjChXlDtbKGGPKfoMdy7tugsMY5oamXt5WmWWELrkCYZwc3+w9zVv0CwURN11ShAzfSgblqfcbUzTLgvcXCFAfrynXFCcZ5WwUP0+KQ5JWKzH8Pv9Gb56b1GF6F7smR+HY=
X-HE-Tag: 1786711553-297725
X-HE-Meta: U2FsdGVkX1/2E4Z2CkAqevHj25D/IINGGaFP2SPdDB85tUkeptoLX11nT5YcveolVh5zzPrH6GylmU8fwewkRU0YdXiEtn7n7YMYudTbFfAWS95UbuUrsvHlyt9zbkVWLYaDuLPP7QmJlsmyeX1Ft9hwPwAv/N24yh05kXA3BqloR9YAvJuDHtrTip3ZfLluxwOGcbhvpDffyKlhMrMsGcsM+S3401kC3hR3fQDrJt8NehKr6gIK8TFcrPzGbOyz7N7/SqGaaxkR42I7l+TNjkdoJ1ycTqEL68uoTpbTsnKTJyREb9BT//5OK0RRqMwG3Mk0RTSmbKFrb8HgcimIfaB6jHpYGkF4rt2TDnyYnrjzOsnqw8lnxw==

On Fri, 14 Aug 2026 08:59:15 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")  
> > 
> > Why the fixes tag? What is it fixing?
> > 
> > -- Steve
> >   
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>  
> >   
> 
> I wasn't too sure about that one. Let me drop it
> 

I already did ;-)

When sending the next patches, please base it off of:

   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  ring-buffer/for-next

As I applied 1-5,7-9 of this series.

Thanks,

-- Steve
