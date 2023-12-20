Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF045C09;
	Wed, 20 Dec 2023 16:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A679C433D9;
	Wed, 20 Dec 2023 16:01:56 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:02:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 0/2] Introducing trace buffer mapping by user-space
Message-ID: <20231220110257.2b338dce@gandalf.local.home>
In-Reply-To: <ZYLw6okkDJq9Pi2O@google.com>
References: <20231219184556.1552951-1-vdonnefort@google.com>
	<20231219153924.2ff9c132@gandalf.local.home>
	<ZYLmvmzLOBfrrsSu@google.com>
	<20231220082932.1b391355@gandalf.local.home>
	<ZYLw6okkDJq9Pi2O@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 13:49:30 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> I meant, to only do in rb_wake_up_waiters()
> 
>   if (rbwork->is_cpu_buffer) 
>   	rb_update_meta_page(cpu_buffer)
> 
> And skip the meta-page update for the !is_cpu_buffer case?

Ah yeah, that works.

-- Steve
