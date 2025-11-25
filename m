Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238F31A81F;
	Tue, 25 Nov 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075705; cv=none; b=jZn7y7Vixc/+UE55pm+IMnZh/lrHAHH1iIg2rNIa+ybikwS9Qn+8Bne2FfDgkICP9I/uyP7qt2ywm+Ys1ldKJF2hlbKV/sVLTIg3uMRhp0WWdRfKP71Ez/bAsGNjZ7RghB3ICU9PiRcfN93FZFI4Ya8L43pEYOq42iNAVbMwoYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075705; c=relaxed/simple;
	bh=vhDkXZtACLobzfgQIVIf22ePHtG54z/L1w308icBQUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nT95Cj8VSYlGCaeyJ1BLKqzg0/CqBnTMs3e8uUDTH68nkPLdu70NCq466Pql8K5wdgkLN8kyqXqnv2SWj6BmWfO32r9v8ZMJg0MZFOhPlacAjpydhewFpm1wHs/ZPgBbHoWGKNPG+1qfcYDYWuVSOyL2KBGHGmOzIl9ql/7syyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKmAz4Sz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKmAz4Sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FDDC4CEF1;
	Tue, 25 Nov 2025 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764075705;
	bh=vhDkXZtACLobzfgQIVIf22ePHtG54z/L1w308icBQUg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WKmAz4Szb3q1tkX81G/hb5Wn9WGMUIU2gtrP25ahAhuPkLyDmOogbUwCYO3AMgCP/
	 qGORkZ5WIjS3ob+3J2iMtseyjmhkwVKjN0vSqh4m8QdJ/fMn8j6nJr5RIWCzEM+SEz
	 nWrHauTGQwMKZxv9Y9VeMANYtMeiQAC12hlhtPhcoJ+0pMSlRbiIcgp2/GDCaiKtiG
	 X5cVUVvWsT2D680UNJtFKJO9d4ysDv+82oj/k1G0mu6nmr4Qia1NmBi8sVwZtKYkWg
	 x0xRr5gjCyZuvvmgHM/UmGblCaU78QRoFb8yt12i0dgyvb3K3QmmgsvFAgI9ObSMnu
	 AwcDONJR/59cA==
Message-ID: <cfa03e4c70ff706b5373bf5314f453930019e1a1.camel@kernel.org>
Subject: Re: [PATCH 2/2] tracing: Merge struct event_trigger_ops into struct
 event_command
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 25 Nov 2025 07:01:43 -0600
In-Reply-To: <20251119031603.658997916@kernel.org>
References: <20251119031042.328864818@kernel.org>
	 <20251119031603.658997916@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steve,

On Tue, 2025-11-18 at 22:10 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> Now that there's pretty much a one to one mapping between the struct
> event_trigger_ops and struct event_command, there's no reason to have two
> different structures. Merge the function pointers of event_trigger_ops
> into event_command.
>=20
> There's one exception in trace_events_hist.c for the
> event_hist_trigger_named_ops. This has special logic for the init and fre=
e
> function pointers for "named histograms". In this case, allocate the
> cmd_ops of the event_trigger_data and set it to the proper init and free
> functions, which are used to initialize and free the event_trigger_data
> respectively. Have the free function and the init function (on failure)
> free the cmd_ops of the data element.
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Very nice as well, just one tiny note below..

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


> ---
> =C2=A0kernel/trace/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 126 +++++++++++------------=
-----
> =C2=A0kernel/trace/trace_eprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 13 +--
> =C2=A0kernel/trace/trace_events_hist.c=C2=A0=C2=A0=C2=A0 |=C2=A0 93 +++++=
+++++----------
> =C2=A0kernel/trace/trace_events_trigger.c | 121 +++++++++++--------------=
-
> =C2=A04 files changed, 152 insertions(+), 201 deletions(-)
>=20

[...]

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index f9cc8d6a215b..1e03398b9e91 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5694,7 +5694,7 @@ static void hist_trigger_show(struct seq_file *m,
> =C2=A0		seq_puts(m, "\n\n");
> =C2=A0
> =C2=A0	seq_puts(m, "# event histogram\n#\n# trigger info: ");
> -	data->ops->print(m, data);
> +	data->cmd_ops->print(m, data);
> =C2=A0	seq_puts(m, "#\n\n");
> =C2=A0
> =C2=A0	hist_data =3D data->private_data;
> @@ -6016,7 +6016,7 @@ static void hist_trigger_debug_show(struct seq_file=
 *m,
> =C2=A0		seq_puts(m, "\n\n");
> =C2=A0
> =C2=A0	seq_puts(m, "# event histogram\n#\n# trigger info: ");
> -	data->ops->print(m, data);
> +	data->cmd_ops->print(m, data);
> =C2=A0	seq_puts(m, "#\n\n");
> =C2=A0
> =C2=A0	hist_data =3D data->private_data;
> @@ -6326,20 +6326,23 @@ static void event_hist_trigger_free(struct event_=
trigger_data *data)
> =C2=A0	free_hist_pad();
> =C2=A0}
> =C2=A0
> -static const struct event_trigger_ops event_hist_trigger_ops =3D {
> -	.trigger		=3D event_hist_trigger,
> -	.print			=3D event_hist_trigger_print,
> -	.init			=3D event_hist_trigger_init,
> -	.free			=3D event_hist_trigger_free,
> -};
> +static struct event_command trigger_hist_cmd;
> =C2=A0

I don't think this is needed, since the same declaration already
appears just above the event_hist_trigger_parse() declaration.

Thanks,

Tom


