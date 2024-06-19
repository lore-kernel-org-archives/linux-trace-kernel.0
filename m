Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246E1E529;
	Wed, 19 Jun 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784308; cv=none; b=p2ysafFitjmX/n7B/yko34jC5WRUf6SUSkaBAT99Ue6OkeXa1Tpcvo8glsbC6c+yb4O00Fb2GYNubDy5HzLVIe6dtEf6J0dTW2m/Dvhk9Ns4IfQBo1bf2dBDPvNWvWBVZ0q2CbUKTGc0MRlYMM0VUv9IsZXqTOOI3MHxenz2wVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784308; c=relaxed/simple;
	bh=A1tLH5hITS/G+nX8aN4oCRm/RURKVPu8lsPy2AFP0Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZouBiz1Xz9q2kZlrOu5wGb+uZfaPOR+KsnNxXc4mpKDIkO3XBVAk02hCcXXvUQM+StO4x2sAgPQngRqwezF0rs8RjnQymecdUQGwIOYjRWibODEYcDpiGFlrUtvvAindbkvfaUbsAw2ID5uwzc77cCZZJvEnfLyR6WZihOwqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvmWN4om; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvmWN4om"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DC1C2BBFC;
	Wed, 19 Jun 2024 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718784307;
	bh=A1tLH5hITS/G+nX8aN4oCRm/RURKVPu8lsPy2AFP0Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvmWN4ombQ/GYSgp8cIpfvD9BYOA92TFxPcU/BaGiqXR5luGFO7ZYLRyl2zjtmkpQ
	 Q6VR30Ez1aD/g2pg64thUOQgzkfUI2pnkrln2nrICX1peylZli5peVb0ZyPucFaveg
	 a2JrG/jSTmIkoaUZzzDf7N+Y9g/tcWwEkm5vGl9oaWJsTTzvRHIYFmjVEJfGs8rU0K
	 Hf0U6JNDbeu6N3MMwK3QgPMVQysVmu5gCUD0BDQD3sWY1aUtBsVYXVischPCdI5J35
	 RZ/O9YiGheLo8HxOVluso3YjySHnWlPIGpkLxsummniUI2lCiX7bphSaHkQZk2Xirm
	 c4ZIoAqTxx24w==
Date: Wed, 19 Jun 2024 11:02:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <ZnKQp_qd9oImOpUe@kernel.org>
References: <20240613155506.811013916@goodmis.org>
 <b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
 <20240613131212.7d1a7ffa@rorschach.local.home>
 <7c90c574-5cfa-40cf-bd4c-1188136cd886@amazon.com>
 <20240617164006.198b9ba3@rorschach.local.home>
 <049b2e0f-00b2-4704-8868-1569a006a134@amazon.com>
 <CAMj1kXF3AetyuLh-QU8yaE-wTLcgyzwuAwe-uo_3EqSDsAYhuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF3AetyuLh-QU8yaE-wTLcgyzwuAwe-uo_3EqSDsAYhuQ@mail.gmail.com>

On Tue, Jun 18, 2024 at 12:21:19PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Jun 2024 at 23:01, Alexander Graf <graf@amazon.com> wrote:
>
> So I would personally prefer for this code not to go in at all. But if
> it does go in (and Steven has already agreed to this), it needs a
> giant disclaimer that it is best effort and may get broken
> inadvertently by changes that may seem unrelated.

I think that reserve_mem= is way less intrusive than memmap= we anyway
have.
It will reserve memory and the documentation adequately warns that the
location of that memory might be at different physical addresses.

-- 
Sincerely yours,
Mike.
