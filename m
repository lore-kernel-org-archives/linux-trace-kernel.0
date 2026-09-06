Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3664392C32
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 04:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667370; cv=none; b=VBaycW+IVC/rjcfBEfFPa2pubO81lC/fVZwi6sFZJrl79XMSg49re/NF2TmfMSNgzKslzEFvKjwrbOKVOlQ6Rx4SVSPJ270CeqfliwE+mnQ07LuK3TtdhZ52zsOM3HONd4eU9cx7nocVwZCyb7VgEDPw7nr/g7tR+5cuqdVgaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667370; c=relaxed/simple;
	bh=ZyZaWr+3jLddQqtXNVSlvvlju6xc06N3QrUtt1V9ncY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gfM+jqqHV6tF/HNkGBaiUZDY0UVPUg7Die8UHH59olNHc1MK4EZtD/UVZ6mvDiOabgD+ZmQ7l9jXYhO0pO/62MmPyjfID6Fys3xatDT/7YA0WITmR8fTjL9X/9tA8fX0kFM6yicTgiXJEsgWarqWz54keh3oFq+8Nuv0b1fKskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWnqZeGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWnqZeGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D46F1F00A3A;
	Sun,  6 Sep 2026 04:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788667368;
	bh=VRKGuANLApz0YMPYHBp7FbGv06Q+yAicrcYz583h4fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWnqZeGeBNvIb9d3Tp5XJB4eJW9FFA1k6UvCPiukJZD+Ewf1wKoWyewwvhK7ODUCc
	 ntf/f6xeFrysHIK3KHZ/SaFNf53Do+S4t7eQUVolViO0LgfWGTE29Dv/9yb5lAYr9F
	 YbDUGrNJabrSnaZbDoTH4SbEo9r47PkE7TPb6Dw12AvwTpCquBPraOMviuELm9eDga
	 Ikheb5YIBJ4BlnIb49pB+0GikBEV03bPa/ZnIOyG4xIBDtTBBlsE347H2fdBHu0DjG
	 u4I7/N5aEcPX+d+om4DgbngQUejHeS+1pgonBodxbw7TMKobzH0foDi2by8wrfQrbu
	 gSgW93ByWkbRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] function_graph: Use the saved entry's size when
 reprinting it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260906034406.1335316-1-donggeunyoo.kernel@gmail.com>
References: <20260906034406.1335316-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 04:02:47 +0000
Message-Id: <20260906040248.3D46F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but state desynchron=
ization when reprinting a previously failed trace entry causes the current =
entry in the ring buffer to be incorrectly consumed and permanently dropped.
- [High] This problem wasn't introduced by this patch, but if the sequence =
buffer fills up while processing the final event in the ring buffer, `print=
_graph_entry()` records a failure state without saving the current entry, c=
ausing uninitialized or stale data reads.
- [High] This problem wasn't introduced by this patch, but the local variab=
le `ret` in `print_graph_entry()` is declared as `static`, creating a data =
race when multiple trace instances or concurrent trace pipe readers are act=
ive.
--

commit ca8f0abc7d748db3bcb46f95c502d76a2725b949
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

function_graph: Use the saved entry's size when reprinting it

This patch fixes an issue where a saved graph entry was reprinted using the
size of the newly processed entry instead of its own original size. By
explicitly saving and restoring ent_size, it prevents argument loss or
truncation when reprinting.

> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index ff7cb1a76b953..c5befd0c5b9a2 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c

[ ... ]

> @@ -1274,6 +1275,7 @@ print_graph_entry(struct ftrace_graph_ent_entry *fi=
eld, struct trace_seq *s,
>  		if (s->full) {
>  			data->failed =3D 1;
>  			data->cpu =3D cpu;
> +			data->ent_size =3D iter->ent_size;

[Severity: High]
This isn't a bug introduced by this patch, but if the sequence buffer fills
up while processing the final event in the ring buffer, could this record a
failure state without saving the current entry, causing uninitialized or
stale data reads?

In get_return_for_leaf(), if the ring buffer is empty on peek, it returns
NULL early:

	if (!event)
		return NULL;

	next =3D ring_buffer_event_data(event);

	if (data) {
		/*
		 * Save current and next entries for later reference
		 * if the output fails.
		 */
		int size =3D min_t(int, sizeof(data->rent), iter->ent_size);

		memcpy(&data->rent, curr, size);

Because the memcpy() is bypassed on the last event, setting data->failed =
=3D 1
unconditionally here on buffer full assumes the entry was successfully save=
d.
On the next read iteration, the trace output may print uninitialized memory
from data->ent.ent.

[Severity: High]
This is a pre-existing issue, but does declaring ret as a static local
variable in print_graph_entry() create a data race?

static enum print_line_t
print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
			struct trace_iterator *iter, u32 flags)
{
	struct fgraph_data *data =3D iter->private;
	struct ftrace_graph_ent *call;
	struct ftrace_graph_ret_entry *leaf_ret;
	static enum print_line_t ret;

If multiple userspace processes concurrently read from different instances =
of
trace_pipe, they execute print_graph_entry() in parallel. If one thread
assigns TRACE_TYPE_PARTIAL_LINE to ret but another thread immediately
overwrites it with TRACE_TYPE_HANDLED, the first thread will incorrectly
return TRACE_TYPE_HANDLED, leading the tracing core to improperly consume an
unprinted event.

>  		} else
>  			data->failed =3D 0;
>  	}
> @@ -1457,6 +1459,7 @@ print_graph_function_flags(struct trace_iterator *i=
ter, u32 flags)
>  	if (data && data->failed) {
>  		field =3D &data->ent.ent;
>  		iter->cpu =3D data->cpu;
> +		iter->ent_size =3D data->ent_size;
>  		ret =3D print_graph_entry(field, s, iter, flags);
>  		if (ret =3D=3D TRACE_TYPE_HANDLED && iter->cpu !=3D cpu) {
>  			per_cpu_ptr(data->cpu_data, iter->cpu)->ignore =3D 1;

[Severity: High]
This is a pre-existing issue, but could this logic cause trace events to be
permanently dropped without being printed?

For trace_pipe reads, get_return_for_leaf() consumes the current entry from
the ring buffer early to peek at the next one:

			/*
			 * We need to consume the current entry to see
			 * the next one.
			 */
			ring_buffer_consume(iter->array_buffer->buffer, iter->cpu,
					    NULL, NULL);

When reprinting a previously failed trace entry here, if the new event is on
the same CPU (iter->cpu =3D=3D cpu), the function fails to set
TRACE_TYPE_NO_CONSUME in print_graph_function_flags():

		if (ret =3D=3D TRACE_TYPE_HANDLED && iter->cpu !=3D cpu) {
			per_cpu_ptr(data->cpu_data, iter->cpu)->ignore =3D 1;
			ret =3D TRACE_TYPE_NO_CONSUME;
		}
		iter->cpu =3D cpu;
		return ret;

Because it returns TRACE_TYPE_HANDLED, the generic iterator assumes the
current entry was handled and consumes it from the ring buffer, permanently
dropping it without printing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906034406.1335=
316-1-donggeunyoo.kernel@gmail.com?part=3D1
