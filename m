Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305C482F2;
	Fri, 27 Dec 2024 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735328620; cv=none; b=nu+qf7MFntkHgZ+4nxBqHEPix36O/ECUw9tZONZGow+pE8gDrQipfis0XR+GsYlCy97YjX1IIJMtFRQw37hODhlkwHFgs7bZGGhxzPc05kWEDh8Ww68Q4TAkRw5DeqlQrdyqAqIMV364S43gk5bC5k8hn4TK70T0lXbFSy9Oc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735328620; c=relaxed/simple;
	bh=YusDc6QgxVoSerecYv+RrbR3Eyv+vQXqyRcZAGJkO5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liciilPBQTy4N1DzcdLRPp0W8a6BLQT7SFN420krRcIhCf1zRlz3IqzJiLxX3ZoQOfic6Jzjx/4h3M1rHhJqCGAo/LgGoj2WESJOdYOmd9tDsUlgRu/hSArrFOzdBUYDyR1UcGa/sDY7FJtOBz83AAaiAQV+HdWnRHst4nibIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93ADC4CED0;
	Fri, 27 Dec 2024 19:43:38 +0000 (UTC)
Date: Fri, 27 Dec 2024 14:44:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Juri
 Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 7/8] verification/dot2k: Auto patch current kernel
 source
Message-ID: <20241227144440.17171185@gandalf.local.home>
In-Reply-To: <20241227144752.362911-8-gmonaco@redhat.com>
References: <20241227144752.362911-1-gmonaco@redhat.com>
	<20241227144752.362911-8-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Dec 2024 15:47:51 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> dot2k suggests a list of changes to the kernel tree while adding a
> monitor: edit tracepoints header, Makefile, Kconfig and moving the
> monitor folder. Those changes can be easily run automatically.
> 
> This patch adds a flag to dot2k to alter the kernel source.

I'll pull in these patches for linux-next, but the above should be written
as:

  Add a flag to dot2k to alter the kernel source.

I made the update. This is for future reference. Never use "This patch" or
"This commit" in a change log.

Thanks,

-- Steve


> 
> The kernel source directory can be either assumed from the PWD, or from
> the running kernel, if installed.
> This feature works best if the kernel tree is a git repository, so that
> its easier to make sure there are no unintended changes.
> 
> The main RV files (e.g. Makefile) have now a comment placeholder that
> can be useful for manual editing (e.g. to know where to add new
> monitors) and it is used by the script to append the required lines.
> 
> We also slightly adapt the file handling functions in dot2k: __open_file
> is now called __read_file and also closes the file before returning the
> content; __create_file is now a more general __write_file, we no longer
> return on FileExistsError (not thrown while opening), a new
> __create_file simply calls __write_file specifying the monitor folder in
> the path.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
