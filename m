Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29B25A62E;
	Fri, 17 Jan 2025 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737074776; cv=none; b=HZdfnh9eDCP2q3+FyJAXhQqB3av7+jxyuwJPn7jy9DINFOWRprVl9K0rhtpcqbZr0WUiZA4QeP9UIhS6UCbQM0zMR9dUCgeRhkhcF35CC3OADv80Q4AOfj/84DyrzlacaExoK51IICfU1nSxkRFR8st0wdgfO7lMoRH9wURbCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737074776; c=relaxed/simple;
	bh=Ap6OpSBJvh9lDIbcEMzmbD6kkuOP9dEP42PhTAIxxVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpn/pIS1vEFPJlHlWCbSHKinofcmmBEojQLqO/kQhTNCa/ww2OUyucyq+zA2RzJJS9flsnkD5VRsoLIZeYS8wI0/EGB7dzet8zXDg8Jd88+iC8T0KSVZdFZlIJPepJNtoPlH0beWU6wgWNVpPKo6EQX+RnGXBcuqH9ttVPfJiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70A4C4CED6;
	Fri, 17 Jan 2025 00:46:14 +0000 (UTC)
Date: Thu, 16 Jan 2025 19:46:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Gabriele
 Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 0/5] rtla/timerlat: Stop on signal properly when
 overloaded
Message-ID: <20250116194621.7b309aed@gandalf.local.home>
In-Reply-To: <20250116144931.649593-1-tglozar@redhat.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 15:49:26 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> In the future, two more patchsets will be sent: one to display how many
> events/samples were dropped (either left in tracefs buffer or by buffer
> overflow), one to improve sample processing performance to be on par with
> cyclictest (ideally) so that samples are not dropped in the cases mentioned
> in the beginning of the email.

Hmm, I wonder if timerlat can handle per cpu data, then you could kick off
a thread per CPU (or a set of CPUs) where the thread is responsible for
handling the data.


		CPU_ZERO_S(cpu_size, cpusetp);
		CPU_SET_S(cpu, cpu_size, cpusetp);
                retval = tracefs_iterate_raw_events(trace->tep,
                                trace->inst,
                                cpusetp,
                                cpu_size,
                                collect_registered_events,
                                                    trace);

And then that iteration will only read over a subset of CPUs. Each thread
can do a different subset and then it should be able to keep up.

-- Steve
