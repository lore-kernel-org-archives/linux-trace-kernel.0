Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7B1CC8A4;
	Thu, 10 Oct 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572134; cv=none; b=gK02gSQUatboAP2RYvJfYuDVbjHSxeqV4sHVqOmmyogFvJK/6D5KLWdneX2qssM3ji4w9bgWyRv+21Q7/Rp/GjkxCuXrcVE6L0f+wl7Xiz/n9fej2Kox+ow7yS+KlC2cfK0r0tPRoEMhxKqI/c33DCqxMtENmd9yER/N5KztdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572134; c=relaxed/simple;
	bh=pQ3bY1ztqpkxEH+mo0S9kpQtrgDuV1YUKiqilJydXf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/XieTOc5Ko3P+e1KYxhPHnmnG0ktYQl/pxmoaZpt3uiZqjVnYCauSeExWpx81Zk5cyvH6ufRluGK+uq2n5usZmybLCV28T1+cuGioy59Gh7Dib8gRfOPQ0qhFSJ0ez/Z1RtT22MRE4wqX+dXQxb5vz3B7FvtKsihyPDpUaCdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EDDC4CEC5;
	Thu, 10 Oct 2024 14:55:32 +0000 (UTC)
Date: Thu, 10 Oct 2024 10:55:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, jforbes@redhat.com, ezulian@redhat.com
Subject: Re: [PATCH 2/2] tools/rtla: fix collision with glibc
 sched_attr/sched_set_attr
Message-ID: <20241010105539.5b5aa41f@gandalf.local.home>
In-Reply-To: <CAP4=nvRLgwu3y_c_m-SdPxaWm6rO_LVFKK98pkjFiLJ42LqhpQ@mail.gmail.com>
References: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
	<45c1f78d4f0e7f1b786443ffdd462d7670ec1634.1728552769.git.jstancek@redhat.com>
	<CAP4=nvRLgwu3y_c_m-SdPxaWm6rO_LVFKK98pkjFiLJ42LqhpQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 14:25:11 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> > --- a/tools/tracing/rtla/src/utils.c
> > +++ b/tools/tracing/rtla/src/utils.c
> > @@ -229,7 +229,7 @@ long parse_ns_duration(char *val)
> >
> >  #define SCHED_DEADLINE         6
> >
> > -static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
> > +static inline int rtla_sched_setattr(pid_t pid, const struct sched_attr *attr,  
> 
> Hmm, rtla_sched_attr sounds to me like the function does something
> specific to rtla. Maybe syscall_sched_attr would be a better name?

Should I be waiting for a v2 with this addressed?

-- Steve
