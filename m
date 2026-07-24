Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E774334CC;
	Fri, 24 Jul 2026 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900533; cv=none; b=lCjxJyQvsszVAhkxhv3U3PimyMGi1vqImL5+dC2ejsdZzAxR+dHALQZ8pSlNXUs3DeFfASLmB7pNJjSkb64r8vhHzqEs1IyF/kqGYzCYqVocU9QJ3ZOX5DvuQl2pzy07f2C+qSi5/210sYEKbRhneB5lOTgV3WCEFplkOSkZlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900533; c=relaxed/simple;
	bh=PGWYipg191tM3PZ+B3HCYYPF8rliq4gMRNKlqOEAuO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTR1y0V55wr08DDXGsSItjmG+Np5gybUFj4bYrcCHlpeqY0DDVuHxJKyPYWK1gIwNbsZMsSbDiOZoxCRtnoaN47CGkRAvnmj6zblMuk7tt920e0FXpBUX0kUjn7quvqwPRxVCyV7rER9RRfG7xqTkze3TjYCkwALTfD6UNa7Bqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B20FB140343;
	Fri, 24 Jul 2026 13:42:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id B35C12002B;
	Fri, 24 Jul 2026 13:42:01 +0000 (UTC)
Date: Fri, 24 Jul 2026 09:42:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Cc: David Carlier <devnexen@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tracing: Fix use-after-free freeing trigger private
 data
Message-ID: <20260724094226.39206825@gandalf.local.home>
In-Reply-To: <20260724030523.19081-1-devnexen@gmail.com>
References: <20260724030523.19081-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B35C12002B
X-Stat-Signature: f4knr8p9i1zm9ruzzcog1gucx671pqy6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dUqIXqX9bmDHdTqQwXvHvFNe+Sahv8+I=
X-HE-Tag: 1784900521-412870
X-HE-Meta: U2FsdGVkX19293VxA6g/SxVn80d+QdbsEN+QLeObkiCHeejqNbPQxL6xId4uT6W5mrgGOg1S+wNmn9Uol+6184+If2SdrqXipAZvszbokkSTDTTwm7sf8ZvWcuysjfxDw5yZfc55cZtYDxFdxsoOzrxKZlLy8LqRknsAHF+vUNuqT+aUwbPeRyDl3Yln//kmHRonOVZkNorW/dLRR/acxZ7737gNvE/OzdMUkhkO+JuwDtNN+hX7DlMzW7IFrpyaNz11801X+ry5re9RfUWXvELirAWGZtitUGuv1fYzFthkVhsQDOUA++N+8UGbImIRKGRiSjbgHONdHRji1SReVEVrhYuq9vop


[ Replying to Sashiko ]

> --- Patch [1]: [PATCH v4] tracing: Fix use-after-free freeing trigger pri=
vate data ---
> commit cd29772ccd2634c1b696094501e9c7fd0bcd1c25
> Author: David Carlier <devnexen@gmail.com>
>=20
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_even=
ts_hist.c
> > index 82ce492ab2681..58d28cd1afa3b 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -6349,6 +6349,7 @@ static void event_hist_trigger_free(struct event_=
trigger_data *data)
> > =20
> >  		trigger_data_free(data);
> > =20
> > +		tracepoint_synchronize_unregister();
> >  		remove_hist_vars(hist_data);
> > =20
> >  		unregister_field_var_hists(hist_data);
>=20
> This isn't a bug introduced by this patch, but since we are fixing the te=
ardown
> paths here, do the error paths in event_hist_trigger_parse() and
> event_enable_trigger_parse() need similar synchronization?
>=20
> For example, in event_hist_trigger_parse():
>=20
> out_free:
> 	remove_hist_vars(hist_data);
> 	trigger_data_free(trigger_data);
> 	destroy_hist_data(hist_data);
>=20
> If trigger registration fails after the trigger was briefly published to
> file->triggers, could a concurrent tracepoint that observed the trigger
> dereference the synchronously freed hist_data because we didn't wait for =
an RCU
> grace period?

Where was it published to file->triggers?

I see it happening as the last operation that can fail. If that fails, then
we hit the error path where it is not registered. Is there someplace it can
become visible and then fail that I'm not seeing?

=46rom what I see, the last command before "success" is:

  ret =3D hist_trigger_enable(trigger_data, file);

And that does:

static int hist_trigger_enable(struct event_trigger_data *data,
			       struct trace_event_file *file)
{
	int ret =3D 0;

	list_add_tail_rcu(&data->list, &file->triggers);

	update_cond_flag(file);

	if (trace_event_trigger_enable_disable(file, 1) < 0) {
		list_del_rcu(&data->list);
		update_cond_flag(file);
		ret--;
	}

	return ret;
}

Now it adds to the file trigger and then tries to enable that event. If it
fails to enable it, it removes it from the list. But if the event is not
enabled, it can't be racing with this.

>=20
> [ ... ]
>=20
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_e=
vents_trigger.c
> > index 655db2e825134..46e60b70a4bbc 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -1728,9 +1740,9 @@ void event_enable_trigger_free(struct event_trigg=
er_data *data)
> >  	if (!data->ref) {
> >  		/* Remove the SOFT_MODE flag */
> >  		trace_event_enable_disable(enable_data->file, 0, 1);
> > +		data->private_data_free =3D enable_trigger_private_data_free;
> >  		trace_event_put_ref(enable_data->file->event_call);
> >  		trigger_data_free(data);
> > -		kfree(enable_data);
> >  	}
> >  }
>=20
> This is a pre-existing issue, but by deferring the kfree of enable_data w=
hile
> keeping trace_event_put_ref() synchronous, could we still face a Use-Afte=
r-Free
> issue during module unload?
>=20
> If trace_event_put_ref(enable_data->file->event_call) allows the target m=
odule
> to be unloaded and its trace event files to be freed immediately, could a
> concurrent tracepoint RCU reader dereference the freed enable_data->file =
in
> event_enable_trigger() when attempting to clear
> EVENT_FILE_FL_SOFT_DISABLED_BIT?

Hmm, this does look like it can be an issue. I'll write up a patch on top
of this one.

-- Steve
