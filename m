Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09453FF1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A124C433C7;
	Wed,  4 Oct 2023 13:56:13 +0000 (UTC)
Date: Wed, 4 Oct 2023 09:57:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org, Ross
 Zwisler <zwisler@google.com>, Mark Rutland <mark.rutland@arm.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH] visl: use canonical ftrace path
Message-ID: <20231004095720.5727254a@gandalf.local.home>
In-Reply-To: <c7e21ecf-9554-425d-a8c1-90f890de6bb4@xs4all.nl>
References: <20230829204600.3210276-2-zwisler@kernel.org>
	<20231003174129.11c79c18@gandalf.local.home>
	<c7e21ecf-9554-425d-a8c1-90f890de6bb4@xs4all.nl>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Oct 2023 08:33:12 +0200
Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:

> On 03/10/2023 23:41, Steven Rostedt wrote:
> > 
> > Could this go through the linux-media tree, or if you give it an Ack, I'll
> > take it through the tracing tree.  
> 
> I prefer to take this through the media subsystem. Ross, can you post this

Thanks!

> patch again, this time including linux-media@vger.kernel.org?

The original patch did have linux-media@vger.kernel.org Cc'd. Was it dropped?

-- Steve


> 
> The patch looks fine, so I'll pick it up.
> 
> Regards,
> 
> 	Hans
