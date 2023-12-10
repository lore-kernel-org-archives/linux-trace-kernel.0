Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7638C11
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B452C433C8;
	Sun, 10 Dec 2023 15:43:59 +0000 (UTC)
Date: Sun, 10 Dec 2023 10:44:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, Kent
 Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 14/14] ringbuffer/selftest: Add basic selftest to test
 chaning subbuf order
Message-ID: <20231210104436.00d94363@gandalf.local.home>
In-Reply-To: <3b45bdf6-234d-4859-8344-c18b48c8b415@efficios.com>
References: <20231210035404.053677508@goodmis.org>
	<20231210040452.274868572@goodmis.org>
	<3b45bdf6-234d-4859-8344-c18b48c8b415@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 09:26:13 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:


> This test has no clue if the record was truncated or not.
> 
> It basically repeats the string
> 
> "1234567890" until it fills the subbuffer size and pads with
> XXXX as needed as trace marker payload, but the grep looks for the
> "1234567890" pattern only.
> 
> The test should be extended to validate whether the trace marker
> payload was truncated or not, otherwise it is of limited value.

It can be, but for now it's just testing to make sure it doesn't crash. I
ran out of time, and if someone else wants to extend this, go ahead.
Currently, my testing has been just manual observations. I threw this in
just to have some kind of smoke test applied.

I agree with the API changes, and will update that. But given that this has
been two years and never applied, is because nobody has the time to work on
this. The reason I'm pushing for this now, is because Kent hit the limit in
his work. Knowing that he would not have hit this limit if these patches
were applied, I feel more urgency on getting them in. But this is all on my
own time, not part of my Employer (hence why I'm working on the weekend).

-- Steve

