Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AE1E231E;
	Wed, 19 Feb 2025 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992193; cv=none; b=XZGv3OpRFy08AwxoAVeYE3sBhq2DSZ7WL1CUMr/LgXiSZxJs5VHp/BZAjp+ZkkcsTuskvqjHUlECfR6uuxHQ+Z71c5w5X/x4dZMP6Xper/iYV2VYfH/htSqFGxJX/DtQotN1+IaglkcYlhLqfAnCSXekEK8nm9B7Y8eINiNLVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992193; c=relaxed/simple;
	bh=m/b1i2F7lHd6HUMXwemEy/s6zC5YC1EnRf56VrRT/sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbgtOooL6DatRHgxLv6QTxGDCzUMZc6qLHtxZsaarSgShrssWPHvck1S2tYhsHnSBkaNTpMKLQ069jDikyx9hfvA/Imbmiz5wPdf+JpZoWjOBKcjS3xdMrLWw8K9jJI+VRGuCPLk6ynv4yC3XSXcaF4BF7M22tykVQrEdWx4HG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A6CC4CED1;
	Wed, 19 Feb 2025 19:09:51 +0000 (UTC)
Date: Wed, 19 Feb 2025 14:10:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] sched: Refine scheduler naming for clarity and
 specificity
Message-ID: <20250219141016.097ada1a@gandalf.local.home>
In-Reply-To: <0245BA04-B0CD-482E-820A-FF5D608FB57E@gmail.com>
References: <20250219182020.393006-1-jemmywong512@gmail.com>
	<20250219182020.393006-2-jemmywong512@gmail.com>
	<20250219134210.51bdf447@gandalf.local.home>
	<0245BA04-B0CD-482E-820A-FF5D608FB57E@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 03:04:02 +0800
Jemmy Wong <jemmywong512@gmail.com> wrote:

> I=E2=80=99ve identified the cause: these changes stem from trailing white=
space,=20
> which my IDE automatically trims by default.=20
> I=E2=80=99ll disable this setting to avoid generating large diffs going f=
orward. =20

Let me guess. vscode?

>=20
> Do I need to revert these changes? I don=E2=80=99t think it matters,=20
> but I=E2=80=99d appreciate your guidance. =20

Yes, please do revert those changes as they have nothing to do with the
patch.

-- Steve
