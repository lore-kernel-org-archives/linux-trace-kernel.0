Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49448375F62
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886468; cv=none; b=JySf1qok3LPTQOgYvklqDFr/CPLsww147d6JiCDTH8iwnbVrBmE2bxRrnJzxKYZoV+GX+adlesR1BG5UvfT5vRZimy5gc28TvAONIiKGwGi0kR28RidqWxTaa1KVeaH7BdWBJnAuttG+/G3Qy818Qz5++6uccVAQo601Q+eszOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886468; c=relaxed/simple;
	bh=qVYY5dj4yOWwMxkl6sgvdwCfiOehrf/ZXCTGrfc0Oqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s94e2+9SL6ZpgyTJBg16kSjQ8osMt0Lxq8QZzRRNlIwN9Tb0lXSKZs47S8kjXSr4pZygrEW4bokZy5xj0x+oSMpwF1beaxa/nKuEBr1CgTdMGd4JpZnD8Y8tuhRUeW3NppeaooJ7vYhP+azg4bhCMKup8mnAOxdt4+PHDinTPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrE1d5wD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrE1d5wD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774886466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ChYhFUMkPlj+xvyDHp2E7u4gejCjKYIu3ppGWiCdJck=;
	b=NrE1d5wD0pnVE1XehVAfjHk2ejZqKKlmyiDlVZ2Fh1R1kFn54MoZoNzKhtZqgIUAOXLTt7
	RhwGUKUFNiS+XD2wvDMGQBJG/Lj1r8yXyE1WRFm9SPln31LWLoawXWh9UqR/KddED5zBCA
	Lt2Bk9IdYFh7kZ7JkFN9LiZzwtDqgDo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-VWF7nM7WMlCrOJP1Q94tYA-1; Mon,
 30 Mar 2026 12:01:04 -0400
X-MC-Unique: VWF7nM7WMlCrOJP1Q94tYA-1
X-Mimecast-MFC-AGG-ID: VWF7nM7WMlCrOJP1Q94tYA_1774886463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E89D1944DC5;
	Mon, 30 Mar 2026 16:01:03 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 11FE730001A2;
	Mon, 30 Mar 2026 16:00:56 +0000 (UTC)
Date: Mon, 30 Mar 2026 13:00:55 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/osnoise: Add option to align tlat threads
Message-ID: <acqeGyWxyCK4H7JV@192.168.0.12>
References: <20260302131316.385987-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260302131316.385987-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: YmSZTpBpsXBucVz9UVj02zHxmzhHgCUWXDWprwnyQ94_1774886463
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2026 at 02:13:16PM +0100, Tomas Glozar wrote:
> Add an option called TIMERLAT_ALIGN to osnoise/options, together with a
> corresponding setting osnoise/timerlat_align_us.
> 
> This option sets the alignment of wakeup times between different
> timerlat threads, similarly to cyclictest's -A/--aligned option. If
> TIMERLAT_ALIGN is set, the first thread that reaches the first cycle
> records its first wake-up time. Each following thread sets its first
> wake-up time to a fixed offset from the recorded time, and increments
> it by the same offset.
> 
> Example:
> 
> osnoise/timerlat_period is set to 1000, osnoise/timerlat_align_us is
> set to 20. There are four threads, on CPUs 1 to 4.
> 
> - CPU 4 enters first cycle first. The current time is 20000us, so
> the wake-up of the first cycle is set to 21000us. This time is recorded.
> - CPU 2 enter first cycle next. It reads the recorded time, increments
> it to 21020us, and uses this value as its own wake-up time for the first
> cycle.
> - CPU 3 enters first cycle next. It reads the recorded time, increments
> it to 21040 us, and uses the value as its own wake-up time.
> - CPU 1 proceeds analogically.
> 
> In each next cycle, the wake-up time (called "absolute period" in
> timerlat code) is incremented by the (relative) period of 1000us. Thus,
> the wake-ups in the following cycles (provided the times are reached and
> not in the past) will be as follows:
> 
> CPU 1		CPU 2		CPU 3	 	CPU 4
> 21080us		21020us		21040us		21000us
> 22080us		22020us		22040us		22000us
> ...		...		...		...
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

