Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6972C0F84;
	Wed,  3 Dec 2025 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801495; cv=none; b=kntyLzkEC0INLyj+uyu++1PiBlNHQJSSrWInJj3ds0vIFEFA/Z9KDCgqwgbn+PQAa9NGHIhOvdsEGm5kApPhGEZJrVHQ6t/5DjZLl2AewtYvT8pe8rElq2xjfYGgK7OpoNTJ9kPSLdt0ZlDwsOL9IsMz68ehjGp5lBEXuuKtrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801495; c=relaxed/simple;
	bh=WYQmiCBKIykpkHIclQvauYbnGBUhmQt5HWureIgeCTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K74f4q9+8gUcw3ZGBYaX1FOSoeUEsHR0WFvXqHAzvYfqdZhJ26tgBoG4BB/2axYcv5gTGh9gVz63NmFLFo2dKZMzeYLanhaqiWToU5qFFimLw1OqVBzKk/V20NBHhGvGovzcgJUf/2d7IXkM2Fg7F7pDaITqgOy3nqUYTOWtpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn3bYpqA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn3bYpqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D791C4CEF5;
	Wed,  3 Dec 2025 22:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764801494;
	bh=WYQmiCBKIykpkHIclQvauYbnGBUhmQt5HWureIgeCTk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Qn3bYpqArJWi0h3w0g/l2FfKwM9+Myy/NYijOT8aY6Kk5b10UfFz6BLfnV0+tCEg3
	 L305XYoHYBO5vSqrTBdK89q8m4AVG3D/6UMKsEaLj2RqTSSG3qbF6paZhlZ/igF7lB
	 E7tpZr4QF4udVoP8VZg63ptLhILO7TuDFICLRyze7rA27o63BFZS4RPNBLoy9x6/ce
	 LTfMTaELPtNSMCZo+WxE63RayZi2n35Ec4FYG8Ne5ghTPyoNoT5ixn66GpEt1Z/inx
	 l1yrNzjEIBGvLm0/i8CSfPe4j0k7b1Faeb+TUmq11xfMnm2dCTC8dn8fAuyRObUOvY
	 DOQCFXgXBBUgQ==
Message-ID: <27ee573f55de645f78969fd9a30cb53bca219144.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] tracing: Remove unneeded event_mutex lock in
 event_trigger_regex_release()
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 03 Dec 2025 16:38:13 -0600
In-Reply-To: <20251125214031.975879283@kernel.org>
References: <20251125214004.396482401@kernel.org>
	 <20251125214031.975879283@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 16:40 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> In event_trigger_regex_release(), the only code is:
>=20
> 	mutex_lock(&event_mutex);
> 	if (file->f_mode & FMODE_READ)
> 		seq_release(inode, file);
> 	mutex_unlock(&event_mutex);
>=20
> 	return 0;
>=20
> There's nothing special about the file->f_mode or the seq_release()
> that
> requires any locking. Remove the unnecessary locks.
>=20
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>


Looks good to me.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> ---
> =C2=A0kernel/trace/trace_events_trigger.c | 4 ----
> =C2=A01 file changed, 4 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_trigger.c
> b/kernel/trace/trace_events_trigger.c
> index 7795af600466..e5dcfcbb2cd5 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -314,13 +314,9 @@ static ssize_t event_trigger_regex_write(struct
> file *file,
> =C2=A0
> =C2=A0static int event_trigger_regex_release(struct inode *inode, struct
> file *file)
> =C2=A0{
> -	mutex_lock(&event_mutex);
> -
> =C2=A0	if (file->f_mode & FMODE_READ)
> =C2=A0		seq_release(inode, file);
> =C2=A0
> -	mutex_unlock(&event_mutex);
> -
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

