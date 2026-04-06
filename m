Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E238B7D1;
	Mon,  6 Apr 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493864; cv=none; b=V/U343wxF/eXiVJKY0cZi2oT+oyNnEe7gtJomH5BB8/X8HL9nctXheLxrvKKx9S8ifw9PKTJDBLOXXfe4ZAsU3rXw384jlv4fyEDP3RM3LTuaL8a7Qks/12amWv6M0QrN+PXhj3lPS3kPCCSQbfVBs34NW0svzHJM55BADb7b4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493864; c=relaxed/simple;
	bh=lCtuL4Res8ASvJOGNX/nxN3vjFbSksdEJ5aKM0p98kM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE0/gg73x5wW0Cp/M8gsJuuJdSVxrsSA0fSke9AhXJ3CUK+tuij5doX42DwijFwZVkoq4bMTPb6/TvdREICvfX91niSiVZPT2hklo82Po0d7DhVQ9N5ddBTJ/5FXQOLNzjBLRRB4MpLyRn9xKKi9q2yjHzk9TN1XQM8rAU8hATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 60FD016048F;
	Mon,  6 Apr 2026 16:44:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id ED37619;
	Mon,  6 Apr 2026 16:44:11 +0000 (UTC)
Date: Mon, 6 Apr 2026 12:45:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: CaoRuichuang <create0818@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: report header_page overwrite as signed
 char
Message-ID: <20260406124523.514ac754@gandalf.local.home>
In-Reply-To: <20260406162843.41592-1-create0818@163.com>
References: <20260406162843.41592-1-create0818@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ED37619
X-Rspamd-Server: rspamout06
X-Stat-Signature: uk3gubjfwoksbtz3zugjg6668smhh17m
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+5OfZ9o4QhdDt0WsISg06UR475DtLl0VM=
X-HE-Tag: 1775493851-704356
X-HE-Meta: U2FsdGVkX18hlcVDMT/5qhe3w+sSp2RPr/IrdtsZW6HyOGAbVWy2v4KQGKrK693AjxhfhGdX/S8Dl++dGLSVoNaYwYEn0cyGSdmRJbk9olROZR3xjygUtAXSTgZJPKhICFgLA4NFhZwS6tQIrsS7/bdpAsidiJ+tG6Rt2h/dbNxfOJrjT9U2n+qnya/NUjx5sqcJq3PvwINamaJc9qEjtwGrzxGO6CiG1w6Tm6l/akJqt5KFpix9P8JBCrygxMN62wA01+A5rVGKv1l0F7OJec2rRt7V2DXRSl90LokcmL+A8Mw1mZXDQvytpvM3t+ETvik72qhPLuAgfOCjT9KYaVmJVDkT3rpIrrKp5d7bO0kzN4Dp1BrVGQ==

On Tue,  7 Apr 2026 00:28:43 +0800
CaoRuichuang <create0818@163.com> wrote:

> The header_page tracefs metadata currently reports overwrite as an
> int field with size 1. That makes parsers warn about a type and
> size mismatch even though the field is only used as a one-byte flag
> within commit.
>=20
> Keep the shared offset with commit as-is, but report overwrite as
> signed char so the declared type matches the hardcoded size and the
> emitted signedness.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216999
> Signed-off-by: CaoRuichuang <create0818@163.com>
> ---
>  kernel/trace/ring_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 170170bd8..c4c2361b0 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -627,11 +627,11 @@ int ring_buffer_print_page_header(struct trace_buff=
er *buffer, struct trace_seq
>  			 (unsigned int)sizeof(field.commit),
>  			 (unsigned int)is_signed_type(long));
> =20
> -	trace_seq_printf(s, "\tfield: int overwrite;\t"
> +	trace_seq_printf(s, "\tfield: signed char overwrite;\t"

=46rom the Bugzilla, the issue was with the rust parser. Would this still not
cause a warning if the "int" was switched to "char" and not "signed char".
The signed is redundant as it is already specified in the fields.

-- Steve


>  			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
>  			 (unsigned int)offsetof(typeof(field), commit),
>  			 1,
> -			 (unsigned int)is_signed_type(long));
> +			 (unsigned int)is_signed_type(signed char));
> =20
>  	trace_seq_printf(s, "\tfield: char data;\t"
>  			 "offset:%u;\tsize:%u;\tsigned:%u;\n",

