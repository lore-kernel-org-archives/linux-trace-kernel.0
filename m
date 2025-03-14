Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF21CD3F;
	Fri, 14 Mar 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955723; cv=none; b=W9yctav7MMnSHwIV/cOiG52MCOwYNqA52y0G6OTJtEkj1//0Cl2X9bTvhJAf/zrSLB4PSOhoNMfG27jN3hQiQhQZh56SSVhMSEtyUy22v02aiqHXWGu3urlw73nXl+UnSBHBmu3jWDqm4/4AD+00JE+njs/Vj29G8sU7Ng8io6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955723; c=relaxed/simple;
	bh=sPpa0S16Aw07+GKZwDOTDWQdVhq1RCOi9LXYURZLHrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fF89rpLEH26+SuwfYZNinOLgz1sMeRvcMjdK4ZyNXQVnhCRRHaF6PLeJxVBTqn9QJUHG4c1OzvuxN+dep7Iqq6T/fkVzCDfIaIrxA+4Fyk9PMLhe6BazTN3lgmezEet0zGHwF9HHX+VXj4c6rrJITglQXsK3FbMg8ZKiqG0I3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D67C4CEE3;
	Fri, 14 Mar 2025 12:35:21 +0000 (UTC)
Date: Fri, 14 Mar 2025 08:35:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
Message-ID: <20250314083518.6b139be8@batman.local.home>
In-Reply-To: <8147edd6-074e-4888-a7a0-798c8d0de612@gmail.com>
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
	<20250312134907.06d27d78@batman.local.home>
	<8147edd6-074e-4888-a7a0-798c8d0de612@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Mar 2025 14:25:25 +0530
Purva Yeshi <purvayeshi550@gmail.com> wrote:

> Got it. If I understand correctly, you=E2=80=99re suggesting that I reord=
er the=20
> patches so that the 'maxdepth' change happens first. That way, I won=E2=
=80=99t=20
> introduce maxdepth: 2 only to change it in the next patch. Does that=20
> sound right?

Exactly!

Thanks,

-- Steev
