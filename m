Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11432D594B;
	Thu, 29 Jan 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769716406; cv=none; b=HleIWzy3VDC0gm3agguEa9cnMotwisb6euSNnm7+6uLnMsLUv0rYOJOQatL2M2F90EmuK9N3rVpvxIx90DykWxNBkGLv9kwS2/rrkLE4Y06kGGAR38GFLIKeglUIroWfO/LshhUVGicqYAlT+tTJZU980fCrGDtpGJFcj5BMWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769716406; c=relaxed/simple;
	bh=J58+4k4bv+5gLypxHyYju4V3V58xR7MCbBJl0bDiLEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7PwwcfDdiA+bNT+Qq5fx4c+uKymR9OBHTMLBDLAXHtYY48yq4aQDz1XS7fhsudFzvNr2kFO8MjpYoLA51yfk7RhkuMmunmlajZvQnLr/1DzQ4JFXhaD7qt2hLYiYeVDTaiRdbUVMK01DYU1Jc86KNGyDglR2jVkaLshZ+kvyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A52851602A9;
	Thu, 29 Jan 2026 19:53:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id DF08C20011;
	Thu, 29 Jan 2026 19:53:21 +0000 (UTC)
Date: Thu, 29 Jan 2026 14:53:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] tracing: Make the backup instance non-reusable
Message-ID: <20260129145333.002815e1@gandalf.local.home>
In-Reply-To: <176955899639.2786091.8716448298561300937.stgit@mhiramat.tok.corp.google.com>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955899639.2786091.8716448298561300937.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 31tc6auis7eopw3cgk56kikh3bync6yi
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DF08C20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PjXbqSneVmTsd3xRxXE853b21tu83L2E=
X-HE-Tag: 1769716401-227086
X-HE-Meta: U2FsdGVkX19852Ug1/EWNUizAq162iQmvSom2K76G7dMeUWUnXfN4mm/pErD/yCGXORqoZ5HOMDVds1H3SlGpwU74ad3LKDE3zyGybOMx+ssVbMnd5feCmN8+JNXV4E4FhrMu6PiBr6xZWxBQRFsd5ipBkIipYC4UEVb+nRXjpT9FvAC/OJ8V0sCH1An9j80SnRqJwguwqBpNvqLFHj1owLS0T5sdwdEcw2zP86WOoZo6ojp0KaQxLKy289qXcJPPYMkIrvuMlXdZXTgheBjbRx5r2Iurrg1H/oJ09YkpE5XaM764i6YphNjpiJH55k3s2CAkN8rDFVTuLDoRdeH4GiLkST7dTZi

On Wed, 28 Jan 2026 09:09:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -9388,12 +9405,16 @@ static void
>  tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
>  {
>  	struct dentry *d_percpu = tracing_dentry_percpu(tr, cpu);
> +	umode_t writable_mode = TRACE_MODE_WRITE;
>  	struct dentry *d_cpu;
>  	char cpu_dir[30]; /* 30 characters should be more than enough */
>  
>  	if (!d_percpu)
>  		return;
>  
> +	if (trace_array_is_readonly(tr))
> +		writable_mode = TRACE_MODE_READ;

Hmm, writable_mode is set but not used?

Looks like you missed an update.

-- Steve

> +
>  	snprintf(cpu_dir, 30, "cpu%ld", cpu);
>  	d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
>  	if (!d_cpu) {
> @@ -9616,7 +9637,6 @@ struct dentry *trace_create_file(const char *name,
>  	return ret;
>  }
