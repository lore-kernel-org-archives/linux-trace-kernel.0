Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF412D6E75;
	Wed, 28 Jan 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633547; cv=none; b=QyPhV+L5twrGDnJ1/xU02ylDFIX+eUHPA9NIW7lVQ6+xta1RmlCXC8MxLczdvprkdtsEFUWLNnsxbgR7VcP4czYmiV+VeDe3uNeAUbh1rZfoh76rv7D+qwYZ0NfJyXL69MB0D50Fgt0ARS8O4C8imu9uZYwT7d594ElxpZQkgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633547; c=relaxed/simple;
	bh=b62khCeZ/rhvqDwrMOk7qWHgkzo1CmySZKVQfvwOhbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vjm+NPMNJlNK4ZRCJs/dlq3i5ydMNgW63Z7KIYEB5DY70oty9GCtv4zpwn+T5/QDPWu6qBhqx3vq5nFIwk1jAwHxJqnFY02hnAa6PUWZplqT4B7OKeRMM91FH03sGq4gt2QTIe0SI7qHmiY0YcHTffnO9RGu/xrBYk34i495BXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2220E8C3A2;
	Wed, 28 Jan 2026 20:52:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id A3F2D2002A;
	Wed, 28 Jan 2026 20:52:16 +0000 (UTC)
Date: Wed, 28 Jan 2026 15:52:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/30] tracing: Introduce trace remotes
Message-ID: <20260128155225.31da0ec6@gandalf.local.home>
In-Reply-To: <20260126104419.1649811-6-vdonnefort@google.com>
References: <20260126104419.1649811-1-vdonnefort@google.com>
	<20260126104419.1649811-6-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f31kg7drewjoy9957a1gqw6gjtfftkok
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A3F2D2002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/vhzK6M22bxGe4NiqcTpWVVnRKoNj9/58=
X-HE-Tag: 1769633536-445104
X-HE-Meta: U2FsdGVkX1/weuzLfX+KUZ2JXl2DZeaNPbJCLkX8KHV73l4PAxpDd89OdEi0bZ16ZfjGJZe2FVxPr9cpEA5fZRSKSeGgJj2k/Si3EWOTHpBAHLHOEeeFWnFsRYJzwIqLpWsv/mz/yNv7gs9jE92Yc7a+wzd3fHkCIWo2Dl2qs5TcPpATF31YuB14nZaJWD5DcqxK3XXWcM1r+pmOH+podcMJAcx47U+Ob3BKvEPhJ3Ksjux7tgHmVDNa8qKx1P3OEmwVJ9HxLh7tGJRb3bUdeH3OOnY9sNpFPqnaTzDWjch2hMJQMFwWjnANppvSf52THV6aaHD+CcGJORorOZHfPcYeqMI0mb2O

On Mon, 26 Jan 2026 10:43:54 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> +	if (!trace_create_file("tracing_on", TRACEFS_MODE_WRITE, remote_d, remote,
> +			       &tracing_on_fops) ||
> +	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
> +			       &buffer_size_kb_fops) ||
> +	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
> +			       &trace_pipe_fops))
> +		goto err;
> +

Oh, and don't do this in an if statement. Make them each individually as:

	ret = trace_create_file(...);
	if (!ret)
		goto err;

Linus hates complex if statements and I can see him having a conniption if
he were to see this.

-- Steve
