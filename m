Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF140627F;
	Tue, 28 Apr 2026 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400845; cv=none; b=QPo7xDAc/e29xnCjlCEXUeJPdcY1i/5XlAaEYGH5uh9Q3rJdY3HdR3/QD+L98Z8UFQyQjzPy5egV1MLKEjfzQDsnIAEEDxQLnZEp6+iWjV3XmBtajKyjGkyWiMJscAC7Fo+5UGEs0P0KiUNhsfBxvO6t4iymj11q8LeV8QHTE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400845; c=relaxed/simple;
	bh=HywBnkKdZA41zZF8oYOd484/6z4d9oU/qhCCivlL0MA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENKDdgAz70k4WxD23SyTaLNNjSkpS1TWAFRm+AwPHj4fJIhWH8hCwongb9zUtU+Pmw83jcHaYBduvqXlJc+H79ETtHfOUA1pJGj9JTbXAP/L1qgRQuTZy2oSmkChLc490NOkvHkFkUbsTA9wDV811GO/8LNDrHfamBSQrOMKfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5863C1201A9;
	Tue, 28 Apr 2026 18:27:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 71F262002E;
	Tue, 28 Apr 2026 18:27:21 +0000 (UTC)
Date: Tue, 28 Apr 2026 14:27:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fprobe: Add unregister_fprobe_sync() for synchronous
 unregistration
Message-ID: <20260428142736.11f5211a@gandalf.local.home>
In-Reply-To: <177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com>
References: <177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 71F262002E
X-Stat-Signature: 3r6wkzxz7tkw1wyxx4t1bojjcko83o8z
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ZJUySwb6+P1ji8MOOtnB0NWQY8ra/NuY=
X-HE-Tag: 1777400841-737513
X-HE-Meta: U2FsdGVkX1/UE7vYaCD4ySjves3psgKeZmfDJcbgw+R9vWVWQL7DGSv2oJCG7qf7dNposyZNUXuH5YOA6YI54ntPX2a35xTf/tOMvrJ+E4Pnvemt692IAD9eOWw6nmyBZFnJde182E9IVgSmnrDLnLOlUF6n3Hhd7VXnlhSjTr3/eBQZW9pNxjRCzOcoAn446ITiAWeh1l76sYFmIebVOWG38xiMQwA66UgTjZZUTwSGClNPvw5RrX/8s+6gkEFQikpaDFeMtJI5dArpPdXVaGYOwVSOtkDInf85iEQWlHai+F122ikt4TMHVWOaxbCHaQyHFAzFmXhn6P7C7me0T5G5k1bbqieF

On Mon, 27 Apr 2026 21:09:58 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> +/**
> + * unregister_fprobe_sync() - Unregister fprobe synchronously with RCU grace period.
> + * @fp: A fprobe data structure to be unregistered.
> + *
> + * Unregister fprobe (and remove ftrace hooks from the function entries) and
> + * wait for the RCU grace period to finish. This is useful for preventing
> + * the fprobe from being used after it is unregistered.
> + *
> + * Return 0 if @fp is unregistered successfully, -errno if not.
> + */
> +int unregister_fprobe_sync(struct fprobe *fp)
> +{
> +	int ret;
> +
> +	guard(mutex)(&fprobe_mutex);
> +	if (!fp || !fprobe_registered(fp))
> +		return -EINVAL;
> +
> +	ret = unregister_fprobe_nolock(fp);
> +	if (ret)
> +		return ret;
> +
> +	synchronize_rcu();

Hmm, do we really need to hold the fprobe_mutex when doing the
synchronize_rcu()? This could cause other updates to have to wait longer
too.

-- Steve


> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(unregister_fprobe_sync);
