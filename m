Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD278C9C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332356; cv=none; b=Q0XYwZFJ51vl3xRMykCdYDw57OHbmkqBHFsj2nf9zKEJv+vJmWjnbxiJeQ+Y+WYJCLD0e2i1ejXcwinPSvXQ0OsH8CK8TRpRkR4/jMRMNY+G8M0oLFvDf44j/hVmOqOB8L67WT3VuscTP6ipJX42LQr8eKdazwt1NNOR1x+ONqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332356; c=relaxed/simple;
	bh=MMqLJwYzJRC224anh3YL0Wcnf+lonmJTpOzfxBPb0TU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QO7IpDYjZuZ831xjG7E86hg6+4PlLudm8mDzvP1MnIgHoX70Uto6+0USERAmq6CpagbrRXCDxQD1YNr6GHhlFDiqad9g9nqndms7FdDykQyS3/prvWXBqwQhzF7nHtEbj9dEnxHZTIuKpNrfhwDFBVZGARmmFOi9T9Uj+0Q+hzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb5PsBZa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb5PsBZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A9F1F000FF;
	Sun, 13 Sep 2026 20:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789332354;
	bh=/uaeuMJK72hb3pt+meeJgTLo2pjVgXCfEFSizioH+dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jb5PsBZae6frY39VjrR+ZoBTsdHns9r0tN/qKV5aUJTk7xe5mP7uMElH3ikDjbA9t
	 4QFfvyG/MBQB51od1zls/va+ktt6jfj7oMY/kpUCZgFgOAKmQ7SNGqXy6+nNCw31gt
	 AB85By5GnXhXqa/8VP2Y+lERzxiQMqQvfUHTcvriwfP0SKdZ/aqv/x0R5tSTN5+FFe
	 nThj/FcYn4rgg3r7j5MD5ld4+k1/Mf5zDX2yrdpRYyyiomCHuZjTfOkxWQ03uKR5UN
	 5OSELc2gP962Vgyo9fdQFclIHiEfGQSpUNKNW986Ql+9i0BDCBXCXvxC2SO69aJeWo
	 R5+YlxL6sm5hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Don't log an error for the speculative field
 variable lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260913203156.941433-1-donggeunyoo.kernel@gmail.com>
References: <20260913203156.941433-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 20:45:54 +0000
Message-Id: <20260913204554.91A9F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of VAR_REF hist_field objects when a variable is refer=
enced 3 or more times.
--

commit de921069f4d7b51b3167c82eacf22c1d74694b83
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: Don't log an error for the speculative field variable lookup

This commit prevents a spurious error log during speculative field variable
lookups in trace events. It silences hist_err() while initially attempting
to create a field variable on the target event, avoiding persistent errors
for fallback matches.

Closes: https://lore.kernel.org/linux-trace-kernel/20260913122523.30f487d9@=
robin/

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fdf..4676dc6d91465 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -806,9 +806,12 @@ static void last_cmd_set(struct trace_event_file *fi=
le, char *str)
>  		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, HIST_PREFIX "%s:%s", system=
, name);
>  }
> =20
> +/* Set while a field lookup may fail silently; the parse path is seriali=
zed. */
> +static bool hist_err_silent;
> +
>  static void hist_err(struct trace_array *tr, u8 err_type, u16 err_pos)
>  {
> -	if (!last_cmd)
> +	if (!last_cmd || hist_err_silent)
>  		return;
> =20
>  	tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing
trace_events_hist.c, I noticed a potential memory leak of var_ref
hist_field objects when a variable is referenced 3 or more times.

Looking at how variables are referenced:

kernel/trace/trace_events_hist.c:create_var_ref() {
    ...
	for (i =3D 0; i < hist_data->n_var_refs; i++) {
		ref_field =3D hist_data->var_refs[i];
		if (ref_field->var.idx =3D=3D var_field->var.idx &&
		    ref_field->var.hist_data =3D=3D var_field->hist_data) {
			get_hist_field(ref_field);
			return ref_field;
		}
	}
    ...
}

This increments the reference count for each additional use of the variable.

During trigger destruction, the teardown logic iterates over the unique
var_ref objects in the hist_data->var_refs array and calls
__destroy_hist_field() exactly once for each. However, looking at the
refcount check:

kernel/trace/trace_events_hist.c:__destroy_hist_field() {
	if (--hist_field->ref > 1)
		return;

	kfree(hist_field->var.name);
    ...
}

If a variable is referenced 3 or more times, its ref count becomes >=3D 3.
Since the single teardown call only decrements the ref count by 1 (leaving
it >=3D 2), the condition > 1 evaluates to true, and the function returns
early without freeing the structure.=20

Does this permanently leak the var_ref object and its dynamically allocated
strings, since __destroy_hist_field() is never called again for that object?

Could this allow a privileged user to reliably exhaust kernel memory by
creating and destroying a tracefs histogram trigger that references the same
variable 3 or more times (e.g., using a variable multiple times in a
synthetic event or an arithmetic expression)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913203156.9414=
33-1-donggeunyoo.kernel@gmail.com?part=3D1
