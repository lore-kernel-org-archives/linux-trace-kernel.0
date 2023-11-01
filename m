Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6A85680
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58825C433C7;
	Wed,  1 Nov 2023 23:47:59 +0000 (UTC)
Date: Wed, 1 Nov 2023 19:47:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Ajay Kaher <akaher@vmware.com>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 4/7] eventfs: Save ownership and mode
Message-ID: <20231101194755.7daa6f60@gandalf.local.home>
In-Reply-To: <20231102084332.754ff8867b7616c36bdf65ad@kernel.org>
References: <20231031223326.794680978@goodmis.org>
	<20231031223420.568912586@goodmis.org>
	<20231102084332.754ff8867b7616c36bdf65ad@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Nov 2023 08:43:32 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 31 Oct 2023 18:33:30 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Now that inodes and dentries are created on the fly, they are also
> > reclaimed on memory pressure. Since the ownership and file mode are saved
> > in the inode, if they are freed, any changes to the ownership and mode
> > will be lost.  
> 
> Do we (need to) allow to change the ownership and mode of the eventfs files?
> I thought it was fixed on the files in tracefs...

Yes, it's the only way to allow non root users access to the tracing directories.

> 
> Otherwise, the code itself looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks!

-- Steve
