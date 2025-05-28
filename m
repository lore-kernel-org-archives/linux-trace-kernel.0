Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85F2868BA;
	Wed, 28 May 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447091; cv=none; b=k5mzMtJanCSOi7g5osc0zjr/Xa0vc2jKzKDdCNgoEFhtJFOJL58U3XzezOlxeQ/mxyz68U+QGrWchVmJU3v/VHYl/0oJZMyzmykzAxXmhhpZT4Ri04cbI8PP1OF2lyGJvFUKPXS3HAUi0Jijk3iqWwO5La+ol5aJSotZ2Q++vw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447091; c=relaxed/simple;
	bh=/gVhh98q0CsWUj0Ko0dbsJEa0IhhuGCKf3Bzxp35yD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XROxVJgDDxAa+Wbj8ntKosPHAYoi9HDu5nzttbO7JiJaqaMI2p5+YCpcXKbgQxSBsmswGfnxoWNmezkzEJxcBlskgGqWayYQhOxZR/Yb4sFjcbEUpm+qv4gqK3tdLtZ1zfqkrwwW1oQ891mBcJ8lH7tQ0nWNVPm3U/s0+PRuWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7993CC4CEE3;
	Wed, 28 May 2025 15:44:49 +0000 (UTC)
Date: Wed, 28 May 2025 11:45:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Eric Mueller <emueller@purestorage.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
Message-ID: <20250528114549.4d8a5e03@gandalf.local.home>
In-Reply-To: <CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
References: <20250411161746.1043239-1-csander@purestorage.com>
	<3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
	<CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 08:16:24 -0700
Caleb Sander Mateos <csander@purestorage.com> wrote:

> Would you mind picking up this patch to remove some old tracepoints?
> Liam has already given it a review.

Someday I need to add code that lists the events that are never called. I
can imagine that there's several tracepoints that are created and never
used, and they still do waste memory :-(

-- Steve
