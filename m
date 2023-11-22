Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA842135B;
	Wed, 22 Nov 2023 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B994DC433CA;
	Wed, 22 Nov 2023 23:39:58 +0000 (UTC)
Date: Wed, 22 Nov 2023 18:40:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] eventfs: Some more minor fixes
Message-ID: <20231122184015.79be22ef@gandalf.local.home>
In-Reply-To: <20231122141925.GE1733890@perftesting>
References: <20231121231003.516999942@goodmis.org>
	<20231122141925.GE1733890@perftesting>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 09:19:25 -0500
Josef Bacik <josef@toxicpanda.com> wrote:

> On Tue, Nov 21, 2023 at 06:10:03PM -0500, Steven Rostedt wrote:
> > Mark Rutland reported some crashes from the latest eventfs updates.
> > This fixes most of them.
> > 
> > He still has one splat that he can trigger but I can not. Still looking
> > into that.  
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks Josef!

-- Steve

