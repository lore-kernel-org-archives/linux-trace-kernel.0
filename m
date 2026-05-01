Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6543019DC;
	Fri,  1 May 2026 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655441; cv=none; b=LQUbvsXDVJHEy14cFcH6p1tfITNK53AsRbaSf2R6NclIgz+ylQpuaZWAOu3VXH2MNG1l483A9iaDq3I9M8QFNdc7nxsVp9+QwQ83m1cChXofsoZ2tvSRTa04phM+pIJaCQIM4H9JmkBsm9F0s99fvz+QxZeY1euhcJbGyzLnzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655441; c=relaxed/simple;
	bh=7MJAmeXEWcyxiGvWctG8X7ZbvdEoNYEi6EKQI8dCsH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kN7F4v/xtDzvcjdQUdltFOLU/IbZEv4cBBL0z8D0IRobyeuEsyhLej+IMZu1AeMKa1HdWh1K0knSZbvOdYNXjhZu64pWLUlEK1+AnkZJY9+zsQp66Wj95Q+scFOWuBZVCeE4AYOIjCZJ3vDPFDYsBjq0FaYgYIW1kLmzJUCdOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTFaCtUf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTFaCtUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C1DC2BCB4;
	Fri,  1 May 2026 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777655441;
	bh=7MJAmeXEWcyxiGvWctG8X7ZbvdEoNYEi6EKQI8dCsH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uTFaCtUfI6BF/PQBozBHLshdRp9vurA2zmja+QHGiEDOiHQkX2F4Y2LF7Ghei6fTn
	 IZ294sPomKUqkLesakJGpH76nV1htJDykCLvnIjeY+TsnuokQgyetYJ8tCqWDatMOO
	 k5r+JB7oA+8c/IPvs4oBHhrqCyiwplRn4HNjqlideyEbXdRTocWmfNfwQ0PkFKEQkF
	 aArwOmnPVPdjJ9d7/XP1TmUQQWGyIqoL8RCA0cdtxepXf33diKuvgs+UuYVTUaSNAK
	 Q3qbnx8jUezuiJ7DjN34CV6VbpHo8PQ6XVZhxZjyfmEUcsEchKb9HB14ZEV+DLwegJ
	 Bo9LGfK+iAGPg==
Message-ID: <097ea2386bfea803f7c33d915f6990b6338e7821.camel@kernel.org>
Subject: Re: [PATCH v6] tracing: Bound synthetic-field strings with seq_buf
From: Tom Zanussi <zanussi@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Steven Rostedt
 <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tom Zanussi
	 <zanussi@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 01 May 2026 12:10:39 -0500
In-Reply-To: <20260430043350.57928-1-pengpeng@iscas.ac.cn>
References: <20260430043350.57928-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pengpeng,

Looks fine to me, just a couple minor nits below..

On Thu, 2026-04-30 at 12:33 +0800, Pengpeng Hou wrote:
> The synthetic field helpers build a prefixed synthetic variable name and
> a generated hist command in fixed MAX_FILTER_STR_VAL buffers. The
> current code appends those strings with raw strcat(), so long key lists,
> field names, or saved filters can run past the end of the staging
> buffers.
>=20
> Build both strings with seq_buf and propagate -E2BIG if either the
> synthetic variable name or the generated command exceeds
> MAX_FILTER_STR_VAL. This keeps the existing tracing-side limit while
> using the helper intended for bounded command construction.
>=20
> Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v5: https://lore.kernel.org/all/20260424070104.1-tracing-sy=
nth-v5-pengpeng@iscas.ac.cn/
> - start a new thread for the new patch revision
> - use a lore link for the previous version in the changelog
> - simplify the synthetic-name construction with seq_buf_printf()
> - keep saved_filter as a normal local variable and avoid an anonymous blo=
ck
>=20
> =C2=A0kernel/trace/trace_events_hist.c | 41 ++++++++++++++++++++++-------=
---
> =C2=A01 file changed, 29 insertions(+), 12 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 0dbbf6cca9bc..aa8e7f043ac0 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/kallsyms.h>
> =C2=A0#include <linux/security.h>
> +#include <linux/seq_buf.h>
> =C2=A0#include <linux/mutex.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/stacktrace.h>
> @@ -2968,14 +2969,23 @@ find_synthetic_field_var(struct hist_trigger_data=
 *target_hist_data,
> =C2=A0			 char *system, char *event_name, char *field_name)
> =C2=A0{
> =C2=A0	struct hist_field *event_var;
> +	struct seq_buf s;
> =C2=A0	char *synthetic_name;

Can you move this down a line, to maintain the reverse Christmas tree
declarations?

> =C2=A0
> =C2=A0	synthetic_name =3D kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> =C2=A0	if (!synthetic_name)
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0
> -	strcpy(synthetic_name, "synthetic_");
> -	strcat(synthetic_name, field_name);
> +	seq_buf_init(&s, synthetic_name, MAX_FILTER_STR_VAL);
> +	seq_buf_printf(&s, "synthetic_%s", field_name);
> +
> +	/* Terminate synthetic_name with a NUL. */
> +	seq_buf_str(&s);
> +

This doesn't hurt, but is it really needed? I think seq_buf_printf()
already null-terminates.

> +	if (seq_buf_has_overflowed(&s)) {
> +		kfree(synthetic_name);
> +		return ERR_PTR(-E2BIG);
> +	}
> =C2=A0
> =C2=A0	event_var =3D find_event_var(target_hist_data, system, event_name,=
 synthetic_name);
> =C2=A0
> @@ -3020,6 +3030,7 @@ create_field_var_hist(struct hist_trigger_data *tar=
get_hist_data,
> =C2=A0	struct trace_event_file *file;
> =C2=A0	struct hist_field *key_field;
> =C2=A0	struct hist_field *event_var;
> +	struct seq_buf s;

Same here.

> =C2=A0	char *saved_filter;
> =C2=A0	char *cmd;
> =C2=A0	int ret;
> @@ -3065,28 +3076,34 @@ create_field_var_hist(struct hist_trigger_data *t=
arget_hist_data,
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0	}
> =C2=A0
> +	seq_buf_init(&s, cmd, MAX_FILTER_STR_VAL);
> +
> =C2=A0	/* Use the same keys as the compatible histogram */
> -	strcat(cmd, "keys=3D");
> +	seq_buf_puts(&s, "keys=3D");
> =C2=A0
> =C2=A0	for_each_hist_key_field(i, hist_data) {
> =C2=A0		key_field =3D hist_data->fields[i];
> =C2=A0		if (!first)
> -			strcat(cmd, ",");
> -		strcat(cmd, key_field->field->name);
> +			seq_buf_putc(&s, ',');
> +		seq_buf_puts(&s, key_field->field->name);
> =C2=A0		first =3D false;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Create the synthetic field variable specification */
> -	strcat(cmd, ":synthetic_");
> -	strcat(cmd, field_name);
> -	strcat(cmd, "=3D");
> -	strcat(cmd, field_name);
> +	seq_buf_printf(&s, ":synthetic_%s=3D%s", field_name, field_name);
> =C2=A0
> =C2=A0	/* Use the same filter as the compatible histogram */
> =C2=A0	saved_filter =3D find_trigger_filter(hist_data, file);
> -	if (saved_filter) {
> -		strcat(cmd, " if ");
> -		strcat(cmd, saved_filter);
> +	if (saved_filter)
> +		seq_buf_printf(&s, " if %s", saved_filter);
> +
> +	/* Terminate cmd with a NUL. */
> +	seq_buf_str(&s);
> +

And here.

> +	if (seq_buf_has_overflowed(&s)) {
> +		kfree(cmd);
> +		kfree(var_hist);
> +		return ERR_PTR(-E2BIG);
> =C2=A0	}
> =C2=A0
> =C2=A0	var_hist->cmd =3D kstrdup(cmd, GFP_KERNEL);

Anyway,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom





