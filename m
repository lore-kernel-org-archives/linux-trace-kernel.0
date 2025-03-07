Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D017DFF3;
	Fri,  7 Mar 2025 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319024; cv=none; b=TnlE2jsbfxPJ+3HbGFhDB/GCD9TqvUkaQ/WimcGnTKgdohHBa2QIqLBE21WOO19gBMhPZY8hPflNm9FsR0Vd6jEN3KMX8VsTCHKd07kTxXcivt76vHCR9LQjMIW0fH2Zd/B1KmuBtKXihy20lR2obqVxVRzAiSt8v60mzzdqxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319024; c=relaxed/simple;
	bh=8dXojX/8uIgxC5WJAgabFATdEMEUTNL7Iiw/XSmjiUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/3dDjlNcwGIl/Ki9crevPTMFiqEAtkOTWhmkRkF1jaoVIgoLJxGylh/MbPQu4sMseX/witHr3aR+tp2dvjUt2q67sLp0gSJ1lomPC/mdBPbgp/eqeNIUgp6XqDG1w4hj+h2CQBC8yiEsX944OSOl9eoDGkCOqsF5gA0GdpP03c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83932C4CEE7;
	Fri,  7 Mar 2025 03:43:42 +0000 (UTC)
Date: Thu, 6 Mar 2025 22:43:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Abaci
 Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] function_graph: Remove the unused variable func
Message-ID: <20250306224341.00cf6291@batman.local.home>
In-Reply-To: <20250307021412.119107-1-jiapeng.chong@linux.alibaba.com>
References: <20250307021412.119107-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  7 Mar 2025 10:14:12 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Variable func is not effectively used, so delete it.
>=20
> kernel/trace/trace_functions_graph.c:925:16: warning: variable =E2=80=98f=
unc=E2=80=99 set but not used.

Thanks, but it should be stated that the variable "func" which came
from "call->func" was replaced by "ret_func" coming from
"graph_ret->func" but "func" wasn't removed after the replacement.

Also:

Fixes: ff5c9c576e754 ("ftrace: Add support for function argument to graph t=
racer")

You don't need to resend. I'll take the patch and update the change log.

-- Steve

>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D19250
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  kernel/trace/trace_functions_graph.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index 71b2fb068b6b..ed61ff719aa4 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -922,7 +922,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  	struct ftrace_graph_ent *call;
>  	unsigned long long duration;
>  	unsigned long ret_func;
> -	unsigned long func;
>  	int args_size;
>  	int cpu =3D iter->cpu;
>  	int i;
> @@ -933,8 +932,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  	call =3D &entry->graph_ent;
>  	duration =3D ret_entry->rettime - ret_entry->calltime;
> =20
> -	func =3D call->func + iter->tr->text_delta;
> -
>  	if (data) {
>  		struct fgraph_cpu_data *cpu_data;
> =20

