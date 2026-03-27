Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72362DC359;
	Fri, 27 Mar 2026 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774638351; cv=none; b=T7w4VoXonC6bwOGP1f1Q4Y6n7PGrPuRFP4WcW1IRSxyHnv74A8Q40dsU8SBR23BF4/xREQUkeryMxyyhoOiXYGpezP1FtJpjTqMlrO5vfIKUSETE5GOCGskhwvO6+Sdh+3wwafGQXbj57701NNHcLxzuvamgz5MveJyEiaEJDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774638351; c=relaxed/simple;
	bh=1+MXbxY07rSTAHQEASdouWRCclslxUhvJ5JcDnT+9WE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuoV3BbgsvldpllXAhmwIIh9740FSS7vxKnNKJTD1kB70DRzL2/YZ6yyRUOHCmq4Wj0b6fE3yRmH/jOpUhF/6t9x24YUJG3xPnMNUxZGxn3FlpBIb+B49A4mxxOVlz89Wpk23gAnW1Ey5DZ4NifqYk7XIXgWSQ6IivSgo4fgw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EB05F5EDEB;
	Fri, 27 Mar 2026 19:05:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id BB5DD23;
	Fri, 27 Mar 2026 19:05:45 +0000 (UTC)
Date: Fri, 27 Mar 2026 15:06:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 tom.zanussi@linux.intel.com
Subject: Re: [PATCH v4 2/2] tracing: Drain deferred trigger frees if kthread
 creation fails
Message-ID: <20260327150634.5df3cf4f@gandalf.local.home>
In-Reply-To: <20260324221326.1395799-3-atwellwea@gmail.com>
References: <20260324221326.1395799-1-atwellwea@gmail.com>
	<20260324221326.1395799-3-atwellwea@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zpbx16dzhadpf6mts74hnqz3mnnpkyh1
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: BB5DD23
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+f0+entMZeiv/N3frOE41hYSpCTebAEkA=
X-HE-Tag: 1774638345-511845
X-HE-Meta: U2FsdGVkX1+mJE93InUbN0Tba/vmwMoE75auR8cbIwoJOW6auIj+qHXE8TAk3FHqYFoqGT4tkLQavYnPH655jvhB7X9V90IvSOBBTACs6n72P5rJQH6yCA0X9AntCMwMHKGZXqMkAv+p09Pyjub58ulUZsGLEO+3yd6NpPtEnHYlHl/dhMKySy50IqHcy9uiPSUjaeHl2aCVQSqR20eYtbyVQ6i9GToj/itwhCpuGNl4TLA0+OPDvznUGgEEAfa91tG9BhK5v+zEa6Pqg3MhBiTL/tpx9spCduO2yQ6Dng1fubXrfzRCHH1hwDrKfF5XhyN3X9GPEgN4aawoINxMj3FbFI994k8W

On Tue, 24 Mar 2026 16:13:26 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

> Boot-time trigger registration can fail before the trigger-data cleanup
> kthread exists. Deferring those frees until late init is fine, but the
> post-boot fallback must still drain the deferred list if kthread
> creation never succeeds.
> 
> Otherwise, boot-deferred nodes can accumulate on
> trigger_data_free_list, later frees fall back to synchronously freeing
> only the current object, and the older queued entries are leaked
> forever.
> 
> Keep the deferred boot-time behavior, but when kthread creation fails,
> drain the whole queued list synchronously. Do the same in the late-init
> drain path so queued entries are not stranded there either.
> 
> Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---

Do you have a test case (kernel command line) that will make
trigger_data_free() get called at boot up?

-- Steve
