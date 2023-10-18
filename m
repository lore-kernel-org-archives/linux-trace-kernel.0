Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E63E017;
	Wed, 18 Oct 2023 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCE0C433C8;
	Wed, 18 Oct 2023 20:52:10 +0000 (UTC)
Date: Wed, 18 Oct 2023 16:52:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>, amd-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 2dac75696c6da3c848daa118a729827541c89d33
Message-ID: <20231018165208.5267a9b9@gandalf.local.home>
In-Reply-To: <202310190456.pryB092r-lkp@intel.com>
References: <202310190456.pryB092r-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 04:07:35 +0800
kernel test robot <lkp@intel.com> wrote:

> Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml:
> Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml:
> fs/tracefs/event_inode.c:782:11-21: ERROR: ei is NULL but dereferenced.

This was already reported and I'm currently testing a patch to fix it.

-- Steve
