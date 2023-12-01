Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TdPdaFZZ"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9751115
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:24:54 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d05e4a94c3so5633625ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455094; x=1702059894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XGfXIS6HVXe6/e9l+81iwua90KgKcNdbupUOWB7Nz4=;
        b=TdPdaFZZ3WviX3IKVUi4jbog10SuoD+yCPANUZKGvaaShxGJwBbme9EtbtTmynM59y
         UFJfAYfnXr+N+oGV/aZIyHaI09G6n242oOl7SQs1Elm0pHOtU1GsfAlR0T/fCkjFoTWn
         AZwww81WmkWbCcHy6EuK4/yFZBOieZW47fpmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455094; x=1702059894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XGfXIS6HVXe6/e9l+81iwua90KgKcNdbupUOWB7Nz4=;
        b=qGsafGWtVUquwtAGBTtVKGh5JX0vIXtYGG5wTxQvjMiu/UWz9g8kNEhCHroERvE1uq
         ThcCpwdMdGr1Y1kWsITpW5ag+mLtsaDAxY476WLoDfP+WTUbK5SPl5ha0wy87msegMS8
         qdaGjUX0P76F3tizCsK7K4oSOl5zttbmdXxXsHc21tKNMogNMayokLWEGg3y6KfExWOr
         lSQX7iduNy3TQDU2cd3gXadtT22bUp6gDyy6MlSSXadlWgnjSBNu//8mzGmT/mvC6Ia9
         ryPOm5JUehFCMe0EdSo5RWqsw27eRT/FkaCjShHhBCw5wuSbtfg4mu1oiEd+e20bwTtH
         st5w==
X-Gm-Message-State: AOJu0YyPkLgIFu4XxWnG7yB+Q8szFQsLOMUFqSagIELNj9m4YdSGkEPl
	knbNraT6yoFfUgav1P5ERGfhAw==
X-Google-Smtp-Source: AGHT+IEKh1U4LPfxGBUf3mJlHka+NhvaJ2NeciUnM51C148o06P3qKGJSwZ6cx5VsvdxmcRwKotuZA==
X-Received: by 2002:a17:902:8e8c:b0:1cc:6cc3:d9eb with SMTP id bg12-20020a1709028e8c00b001cc6cc3d9ebmr24187576plb.68.1701455094201;
        Fri, 01 Dec 2023 10:24:54 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001cf7bd9ade5sm344223plw.3.2023.12.01.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:24:53 -0800 (PST)
Date: Fri, 1 Dec 2023 10:24:52 -0800
From: Kees Cook <keescook@chromium.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Message-ID: <202312011024.8FD7DD329F@keescook>
References: <20231130205607.work.463-kees@kernel.org>
 <20231201152726.91421003ccd64eb5e369043c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201152726.91421003ccd64eb5e369043c@kernel.org>

On Fri, Dec 01, 2023 at 03:27:26PM +0900, Masami Hiramatsu wrote:
> On Thu, 30 Nov 2023 12:56:08 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > strlcpy() reads the entire source buffer first. This read may exceed
> > the destination size limit. This is both inefficient and can lead
> > to linear read overflows if a source string is not NUL-terminated[1].
> > Additionally, it returns the size of the source string, not the
> > resulting size of the destination string. In an effort to remove strlcpy()
> > completely[2], replace strlcpy() here with strscpy().
> > 
> > The negative return value is already handled by this code so no new
> > handling is needed here.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
> > Link: https://github.com/KSPP/linux/issues/89 [2]
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: linux-trace-kernel@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Hi Kees,
> 
> As same as sample's change, should I ask you to pick this to your tree?
> Since it is a kind of a part of series patch. I'm OK for it since this
> does not change the code so much.
> 
> In that case, please feel free to add my Ack.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Either way is fine, but I can take it since I've got a few others
already too. :)

Thanks!

-Kees

-- 
Kees Cook
