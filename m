Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E9A20;
	Wed, 13 Dec 2023 00:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724A5C433C8;
	Wed, 13 Dec 2023 00:15:03 +0000 (UTC)
Date: Tue, 12 Dec 2023 19:15:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Mark
 Rutland <mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
 <pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
 <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/15] tracing: Introduce names for ring buffers
Message-ID: <20231212191546.603c0703@gandalf.local.home>
In-Reply-To: <20231213000452.88295-9-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
	<20231213000452.88295-9-graf@amazon.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 00:04:45 +0000
Alexander Graf <graf@amazon.com> wrote:

> With KHO (Kexec HandOver), we want to preserve trace buffers across
> kexec. To carry over their state between kernels, the kernel needs a
> common handle for them that exists on both sides. As handle we introduce
> names for ring buffers. In a follow-up patch, the kernel can then use
> these names to recover buffer contents for specific ring buffers.
> 

Is there a way to use the trace_array name instead?

The trace_array is the structure that represents each tracing instance. And
it already has a name field. And if you can get the associated ring buffer
from that too.

struct trace_array *tr;

	tr->array_buffer.buffer

	tr->name

When you do: mkdir /sys/kernel/tracing/instance/foo

You create a new trace_array instance where tr->name = "foo" and allocates
the buffer for it as well.

-- Steve
