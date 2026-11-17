Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928148;
	b=wQZd3jkqnSCs54i3JiZTT+dira1lnPHbNLefpR9yJMmMQGBx6oIjsAWUJs5ipmwf7rYb
	 7D14oAH24fYkil7KEUVw5NcoreO5VHl5kgkBUcwusFYNEmDUpVfqrVR6UYyQPW47htT+8
	 eHKasHTlVinh7L7pdZa1nxSwKKGnuhMi3VaAo/jCXQT55W7EKYjLIeWtjLKq15kHgsw5G
	 aMOAhyz4EwDImxQGv7q2V/PZX4ybds4+ri0K+KWKxbGH1vgGZ3gmbG6Ujgow6ghQpzJ1/
	 qI3dEm4JJZzmB7euQy0CVGa0Xwxh2EmkZ/xhLgMgzWZI8uWQYW5fz9gIERw0HykJ7JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928148;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=dB4cEew9f/WAFHAIo06tqARg2yEsqJ/BPWF9uWXg0cQ=;
	b=CLT7xw15CtGf4hIQUJLg6tA5OBJgFhHHNWWCe6/nkHc8GxouP+m08bfUleP22fk5Mjqr
	 NtPbK/ln8tQ+p2Dj6uf3zOB9nu7HUYB6oYy4k8of/8EdVhqd8XdnR/a9yXzu0sdcYtlJz
	 wR3e8O2cnt01F4gxnKCxDUczyCIa4NrvgGm490PwTd+pCP2h9/0UFPcU2uNf+WcbnBCjJ
	 mdR/o6kCMu68QL6NHR6B26LW40iuF/WNPi7a9fjS1LJyDkeuHvTltTv5ozshpyEYvZPXw
	 9wz556w/FM+4OaD50KaQdpnLJBNAgmJTxX7JfGNGYaPeojP3vcf7vjVlaoFI86xN/Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=I7WO0ys4;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E064606A31C;
	Tue, 17 Nov 2026 15:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E064606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=I7WO0ys4
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id AE879A043D;
	Tue, 17 Nov 2026 15:08:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 7AB0020025;
	Tue, 17 Nov 2026 15:08:57 +0000 (UTC)
Date: Tue, 17 Nov 2026 10:08:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Yu Peng
 <pengyu@kylinos.cn>, Thomas Gleixner <tglx@kernel.org>, "Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= (Schneider Electric)"
 <thomas.weissschuh@linutronix.de>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: avoid comparing string against NULL
Message-ID: <20261117100856.40ec1f4f@gandalf.local.home>
In-Reply-To: <20261013205412.2579779-1-arnd@kernel.org>
References: <20261013205412.2579779-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7AB0020025
X-Stat-Signature: n4t8f1yr9zcb4kxbfg87wfytyuhem7it
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/AES1H3mwHw2CmEzzgezaItoK2LXirnME=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=dB4cEew9f/WAFHAIo06tqARg2yEsqJ/BPWF9uWXg0cQ=; b=I7WO0ys4IpOknvK4YzTIR4/C3qghf7rvhv2epO/kn35gd9qargQ0G7pPfqrtSWqu0gREMPs0d6O0g83fM+xw909prnY/sI29fy59ep4GYTcGaPSliZuY1i+eJ3Loxhx8d0JYnSJBjIj2ZRgXBF5O3lRvS3MY5lr5WaDRVpdlOy0=
X-HE-Tag: 1794928137-531490
X-HE-Meta: U2FsdGVkX183wCMP7PwSqG4C6WGCBPRdxRl1aAuJSCQE6LU4esxy7fh08eYuee06Q4jgWaSxdxWrpQresmj7r6C5pqeKHUu5YMLoSfLKcuTp9MyeBJEBQ7V/cQK69TEAzcGXBXys4OX1JyEposRjZ1NkWToRVceJw21QTI0/LG9l9rdFVxKoPjM0cKVyDoM+msds5GEZPuWljymygmJlvikGHvG/7Ui+7FSAHrVrf4mf9ZCXOMC4sOFqQ+4+RhTc7mJjRWovU6tq9VbKGU9ayyTP8r1TIF4anBcLECgIfOB4mklal3Y3uP3qMHkNQvcLgIG7HUmNBZFiX9r9DnuzBqUw9YHvEFzR

On Tue, 13 Oct 2026 22:53:52 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-10 warns about passing a NULL argument into __synth_event_add_val(),
> which uses it in an unchecked strcmp():
> 
> In function '__synth_event_add_val',
>     inlined from 'synth_event_add_next_val' at kernel/trace/trace_events_synth.c:2162:9:
> kernel/trace/trace_events_synth.c:2076:8: error: argument 2 null where non-null expected [-Werror=nonnull]
>  2076 |    if (strcmp(field->name, field_name) == 0)
>       |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/string.h:65,
>                  from kernel/trace/trace_events_synth.c:8:
> kernel/trace/trace_events_synth.c: In function 'synth_event_add_next_val':
> arch/s390/include/asm/string.h:39:5: note: in a call to function 'strcmp' declared here
>    39 | int strcmp(const char *s1, const char *s2);
>       |     ^~~~~~
> 
> The code is actually correct here, as the trace_state->add_name
> does check for it, but this is hard for the compiler to prove.
> 
> Avoid the problem by repeating the check where the compiler
> sees it.

Yeah, but the compiler is being stupid here. It's not that difficult for it
to see it.


	if (field_name) {                      <<-- checks field_name
		if (trace_state->add_next) {
			ret = -EINVAL;
			goto out;
		}
		trace_state->add_name = true;  <<-- set add_name
	} else {
		if (trace_state->add_name) {  <<-- If field_name is NULL and add name is set, error out here
			ret = -EINVAL;
			goto out;
		}
		trace_state->add_next = true;
	}

	if (trace_state->disabled)
		goto out;

	event = trace_state->event;
	if (trace_state->add_name) {  <<-- Only get here if add_name is set (thus field_name is not NULL)
		for (i = 0; i < event->n_fields; i++) {
			field = event->fields[i];
			if (strcmp(field->name, field_name) == 0)   <<-- test field_name
				break;
		}

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/trace/trace_events_synth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index dc15658a887c..c1287ca95aff 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -2073,7 +2073,8 @@ static int __synth_event_add_val(const char *field_name, u64 val,
>  	if (trace_state->add_name) {
>  		for (i = 0; i < event->n_fields; i++) {
>  			field = event->fields[i];
> -			if (strcmp(field->name, field_name) == 0)
> +			if (!field_name ||
> +			    strcmp(field->name, field_name) == 0)

I don't like making the code look worse to please something stupid the
compiler is doing.

-- Steve


>  				break;
>  		}
>  		if (!field) {

