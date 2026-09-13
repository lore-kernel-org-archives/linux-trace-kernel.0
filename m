Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D62D2382
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332184; cv=none; b=eXEqv7KHYhMPh4nMh+yWV6Gw4+AgWgFt48r9x22omf1Y9zzdnDKOcpQSCXijg1rUc/840yFBsmoVpLP9S+JXLp3nnroR1wR2vVJ/czcczWUP8r0tKo2OhNyKwpFhiEI12FmIjdWdiDGZIG0SAiOQ7P7yZQ9Gl3Ea+Ey7xDr0Afo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332184; c=relaxed/simple;
	bh=0wFFz4ZKooJcTZ9wtwe4fBXDbhoCp8AufKzhTaNrdQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fOI96beFzJ08zoOFQeTLcIxLh7ibNt1jKIbB5OFQU9BKGfSPR1mSa+N45HCkwQAsY2rlTftXORUaZGw1xMQKbh0HinVbeHw7KM+Pn1SikcHb5xChKsH1tofCR66ccVQasJvJd7Mu5q/Fp83WhQlffX3OMuthPUn0FicTjRLFmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXgL8bfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXgL8bfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2551F000FF;
	Sun, 13 Sep 2026 20:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789332183;
	bh=jZRplENl+04vQRDrR701MxncwntlXA4GQGJesXIAG/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UXgL8bfkC69RULn+YmgWpOhixdAMdnidErgr96e+k83TSJB8MMKtU0hM3YwOoOG9t
	 DBAwP/c0gxgx6KzQcBpFyu7VBNmuJgPwBfl+we/xk6/B2E/kaO2Olm/zgN2uQe13aI
	 Jnt9Khp5+0yK6wRRcNRZTMiwjk89xFkJCz0NRzlk3ezHP5Si2kIbk+GJEtrGtDvjGM
	 ZxOiJS+Y38K5nhfaJN8au4TcmeJOGaW4n0WnV0Ov2scKidCoqFJHH1v0dcLC6DChcj
	 IvuFfkMHUrwYZtnY1E5pVNkE/tKD+rT9Prt+ODrsFmbgz+oFRKXttzu7SbHMH1fHp6
	 1gq6zos76ULpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] tracing: Fix NULL dereference when copying keys
 for a field variable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260913203129.941270-3-donggeunyoo.kernel@gmail.com>
References: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
 <20260913203129.941270-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 20:43:02 +0000
Message-Id: <20260913204302.DB2551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaked synthetic field variable histogram triggers on error paths =
in `create_field_var_hist()` and `event_hist_trigger_parse()`.
--

commit d9bdb20cb47a42dc8d2becde420531d33d458afb
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: Fix NULL dereference when copying keys for a field variable

This commit fixes a NULL pointer dereference in create_field_var_hist()
by using expr_field_str() to retrieve the field name instead of accessing
the name directly. This prevents crashes when handling pseudo field types
like common_cpu.

Cc: stable@vger.kernel.org
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 9d7ce01fda360..b43b83d7c6f39 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3097,7 +3097,7 @@ create_field_var_hist(struct hist_trigger_data *tar=
get_hist_data,
>  		key_field =3D hist_data->fields[i];
>  		if (!first)
>  			seq_buf_putc(&s, ',');
> -		seq_buf_puts(&s, key_field->field->name);
> +		expr_field_str(key_field, &s);
>  		first =3D false;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does create_field_var_hist() leak
synthetic field variable histogram triggers on error paths?

Later in create_field_var_hist(), if the histogram trigger is successfully
registered but find_synthetic_field_var() subsequently fails:

	ret =3D event_hist_trigger_parse(&trigger_hist_cmd, file,
				       "", "hist", cmd);
	if (ret) {
		...
	}

	kfree(cmd);

	/* If we can't find the variable, something went wrong */
	event_var =3D find_synthetic_field_var(target_hist_data, subsys_name,
					     event_name, field_name);
	if (IS_ERR_OR_NULL(event_var)) {
		kfree(var_hist->cmd);
		kfree(var_hist);
		hist_err(tr, HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
		return ERR_PTR(-EINVAL);
	}

It appears the tracking reference is dropped without unregistering the
newly created sub-trigger.

Similarly, in event_hist_trigger_parse(), if a subsequent action fails:

		ret =3D create_actions(hist_data);
		if (ret)
			goto out_free;

The out_free path destroys the tracking structures via destroy_hist_data()
but doesn't appear to call unregister_field_var_hists() to unregister them:

 out_free:
	remove_hist_vars(hist_data);

	trigger_data_free(trigger_data);

	destroy_hist_data(hist_data);
	goto out;

Could this allow userspace to trigger a memory leak or memory exhaustion
by repeatedly writing malformed histogram triggers with invalid actions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913203129.9412=
70-1-donggeunyoo.kernel@gmail.com?part=3D2
